local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
  end,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
