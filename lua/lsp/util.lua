local M = {}

M.key_attach = function(bufnr)
  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end
  -- keybingings
  require("configs.core.keybindings").map_LSP(buf_set_keymap)
end

-- disable format, handle it to a dedicated plugin
M.disable_format = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.flags = {
  debounce_text_changes = 150,
}

M.default_configs = function()
  return {
    capabilities = M.capabilities,
    flags = M.flags,
    on_attach = function(client, bufnr)
      M.disable_format(client)
      M.key_attach(bufnr)

      require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      }, bufnr)
    end,
  }
end

return M
