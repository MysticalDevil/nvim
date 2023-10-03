local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "ruby" }
opts.settings = {}
opts.init_options = {
  formatter = "auto",
}
opts.root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git")
opts.single_file_support = true

return util.set_on_setup(opts)
