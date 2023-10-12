local lsp_util = require("lspconfig.util")
local util = require("lsp.util")

local opts = util.default_configs()
opts.filetypes = { "clojure", "edn" }
opts.root_dir = function(fname)
  return lsp_util.root_pattern("project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", "bb.edn")(fname)
    or lsp_util.find_git_ancestor(fname)
end

return util.set_on_setup(opts)
