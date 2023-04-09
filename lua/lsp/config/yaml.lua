local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
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
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemas = {
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
