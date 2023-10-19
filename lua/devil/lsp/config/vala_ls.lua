local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "vala", "genie" }
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern("meson.build")(fname)
    or require("lspconfig.util").find_git_ancestor()(fname)
end
opts.single_file_support = true

return util.set_on_setup(opts)
