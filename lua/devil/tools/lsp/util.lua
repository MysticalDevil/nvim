local M = {}

local notify = require("devil.shared.notify")
local treesitter_foldexpr = "v:lua.vim.treesitter.foldexpr()"
local lsp_foldexpr = "v:lua.vim.lsp.foldexpr()"

function M.key_attach(bufnr)
  require("devil.core.mappings").setup_lsp(bufnr)
end

---@return table
function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

---@return table
function M.flags()
  return {
    debounce_text_changes = 150,
  }
end

function M.default_on_attach(_client, bufnr)
  M.key_attach(bufnr)
end

function M.set_lsp_foldexpr(client, bufnr)
  if not (client and client:supports_method("textDocument/foldingRange")) then
    return
  end

  vim.b[bufnr].devil_lsp_foldexpr = true
  for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
    if vim.api.nvim_win_is_valid(winid) then
      vim.wo[winid].foldexpr = lsp_foldexpr
    end
  end
end

function M.restore_foldexpr(bufnr)
  vim.b[bufnr].devil_lsp_foldexpr = nil
  for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
    if vim.api.nvim_win_is_valid(winid) then
      vim.wo[winid].foldexpr = treesitter_foldexpr
    end
  end
end

function M.set_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  if client.name == "phpactor" then
    notify.debug("Skip inlay hints for LSP: " .. client.name)
    return
  end

  -- Enabled only it supported
  local ok = client:supports_method("textDocument/inlayHint")
    or (client.server_capabilities and client.server_capabilities.inlayHintProvider)
  if not ok then
    return
  end

  -- Enable inlay hint
  pcall(function()
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end)
end

function M.enable_inlay_hints_autocmd()
  local ih_group = vim.api.nvim_create_augroup("LspSetup_Inlayhints", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = ih_group,
    pattern = "*",
    callback = function()
      vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })
    end,
  })
  vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = ih_group,
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client then
        M.set_inlay_hints(client, bufnr)
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = ih_group,
    callback = function(args)
      if vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }) then
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
        vim.api.nvim_buf_set_var(args.buf, "inlayhint_saved_state", true)
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = ih_group,
    callback = function(args)
      local ok, state = pcall(vim.api.nvim_buf_get_var, args.buf, "inlayhint_saved_state")
      if ok and state then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.api.nvim_buf_del_var(args.buf, "inlayhint_saved_state")
      end
    end,
  })
end

function M.enable_lsp_folding_autocmd()
  local group = vim.api.nvim_create_augroup("LspSetup_Folding", { clear = true })

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
      if vim.b[args.buf].devil_lsp_foldexpr then
        vim.wo[0].foldexpr = lsp_foldexpr
      end
    end,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = group,
    callback = function(args)
      local still_has_lsp_folding = false

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
        if client.id ~= args.data.client_id and client:supports_method("textDocument/foldingRange") then
          still_has_lsp_folding = true
          break
        end
      end

      if still_has_lsp_folding then
        return
      end

      M.restore_foldexpr(args.buf)
    end,
  })
end

function M.enable_dynamic_capability_attach()
  if vim.g.devil_lsp_dynamic_attach_enabled then
    return
  end

  vim.g.devil_lsp_dynamic_attach_enabled = true

  local overridden = vim.lsp.handlers["client/registerCapability"]
  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx, config)
    local result
    if overridden then
      result = overridden(err, res, ctx, config)
    end

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return result
    end

    for bufnr, _ in pairs(client.attached_buffers) do
      M.default_on_attach(client, bufnr)
      M.set_lsp_foldexpr(client, bufnr)
      M.set_inlay_hints(client, bufnr)
    end

    return result
  end
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        on_attach(client, buffer)
      end
    end,
  })
end

return M
