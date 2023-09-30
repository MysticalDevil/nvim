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

return util.set_on_setup(opts)
