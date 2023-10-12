local lsp_util = require("lspconfig.util")
local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "kotlin" }
opts.root_dir = function(fname)
  return lsp_util.root_pattern("settings.gradle", "settings.gradle.kts")(fname)
end

return util.set_on_setup(opts)
