local util = require("devil.lsp.util")

local opts = util.default_configs()

opts.filetypes = { "css", "scss", "less" }
opts.settings = {
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
}

return util.set_on_setup(opts)
