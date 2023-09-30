local lsp_util = require("lspconfig.util")
local util = require("lsp.util")

local opts = util.default_configs()
opts.filetypes = { "clojure", "edn" }
opts.root_dir = lsp_util.root_pattern("project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn")

return util.set_on_setup(opts)
