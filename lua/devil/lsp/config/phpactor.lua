local lsp_util = require("lspconfig.util")
local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "php" }

opts.root_dir = function(fname)
  return lsp_util.root_pattern("composer.json")(fname) or lsp_util.find_git_ancestor(fname)
end

return util.set_on_setup(opts)
