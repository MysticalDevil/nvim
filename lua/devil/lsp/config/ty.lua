local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.settings = {
  ty = {
    inlayHints = {
      variableTypes = true,
      callArgumentNames = true,
    },
    completions = {
      autoImport = true,
    },
    diagnosticMode = "workspace",
  },
}

return opts
