local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  solargraph = {
    diagnostics = true,
  },
}

opts.single_file_support = true

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
