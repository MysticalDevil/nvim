local lsp_util = require("lspconfig.util")
local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "kotlin" }
opts.root_dir = lsp_util.root_pattern("settings.gradle", "settings.gradle.kts")

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
