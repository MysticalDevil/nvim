local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "perl" }
opts.settings = {
  perl = {
    perlcritic = {
      enabled = false,
    },
    syntax = {
      enabled = true,
    },
  },
}
opts.single_file_support = true

return util.set_on_setup(opts)
