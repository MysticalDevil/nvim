local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  }

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
