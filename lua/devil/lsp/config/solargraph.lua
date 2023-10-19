local util = require("devil.lsp.util")

local opts = util.default_configs()

opts.settings = {
  solargraph = {
    diagnostics = true,
  },
}

opts.single_file_support = true

return util.set_on_setup(opts)
