local M = {}

local utils = require("devil.utils")
local notify = require("devil.utils.notify")

function M.key_attach(bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })
end

-- disable format, handle it to a dedicated plugin
function M.disable_format(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
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

function M.default_on_attach(client, bufnr)
  M.disable_format(client)
  M.key_attach(bufnr)

  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
end

function M.set_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  -- Filtering unstable LSPs
  local blocker_lsps = {
    ["null-ls"] = true,
    ["phpactor"] = true,
    ["zls"] = false,
  }
  if blocker_lsps[client.name] then
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

      if client and require("devil.utils").not_proxy_lsp(client.name) then
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
