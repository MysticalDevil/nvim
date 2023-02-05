local common = require("lsp.common-config")
local opts = {
  on_attach = function(_, bufnr)
    common.keyAttach(bufnr)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
    require("nvim-navic").attach(client, bufnr)
  end,
  -- require("coq").lsp_ensure_capabilities(),
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
