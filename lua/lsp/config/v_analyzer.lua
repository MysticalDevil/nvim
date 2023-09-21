local lsp_util = require("lspconfig.util")
local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "v", "vsh", "vv" }
opts.root_dir = lsp_util.root_pattern("v.mod", ".git")

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
