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
  settings = {
    css = {
      validate = true,
      -- tailwindcss
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
  require("coq").lsp_ensure_capabilities(),
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
