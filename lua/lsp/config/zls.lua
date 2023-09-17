local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "zig", "zir" }
opts.single_file_support = true

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
