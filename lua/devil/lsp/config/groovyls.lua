local lsp_util = require("lspconfig.util")
local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "groovy" }
opts.root_dir = function(fname)
  return lsp_util.root_pattern("Jenkinsfile")(fname) or lsp_util.find_git_ancestor(fname)
end

opts.single_file_support = true

return util.set_on_setup(opts)
