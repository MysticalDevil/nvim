local util = require("lsp.util")
local opts = util.default_configs

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
