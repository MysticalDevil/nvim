local util = require("lsp.util")
local opts = util.default_configs()

opts.cmd = { "racket", "--lib", "racket-langserver" }
opts.filetypes = { "racket", "scheme" }
opts.single_file_support = true

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
