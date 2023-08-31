local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
    solargraph = {
      diagnostics = true,
    },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
