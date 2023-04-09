local common = require("lsp.common-config")
local opts = {
  on_attach = function(client, bufnr)
    common.keyAttach(bufnr)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
