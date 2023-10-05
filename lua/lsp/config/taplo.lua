local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "toml" }
opts.root_dir = require("lspconfig.util").root_pattern("*.toml", ".git")
opts.single_file_support = true

return util.set_on_setup(opts)
