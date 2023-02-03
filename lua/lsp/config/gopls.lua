local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.keyAttach(bufnr)
    -- common.disableFormat(client)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
  end,
  -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  -- require("coq").lsp_ensure_capabilities(),
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
