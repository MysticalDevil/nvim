local M = {}

local utils = require("devil.utils")

local inlay_hint = vim.lsp.inlay_hint

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

  return vim.lsp.protocol.make_client_capabilities()
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

  M.set_inlay_hints(client, bufnr)

  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
end

function M.default_configs()
  return {
    capabilities = M.common_capabilities(),
    flags = M.flags(),
    on_attach = M.default_on_attach,
  }
end

function M.set_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  if client.name == "zls" then
    vim.g.zig_fmt_autosave = 1
  end

  if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
    inlay_hint.enable(bufnr, true)
  end
end

function M.enable_inlay_hints_autocmd()
  vim.api.nvim_create_augroup("LspSetup_Inlayhints", { clear = true })
  vim.cmd.highlight("default link LspInlayHint Comment")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspSetup_Inlayhints",
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
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

return M
