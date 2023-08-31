local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  }

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
