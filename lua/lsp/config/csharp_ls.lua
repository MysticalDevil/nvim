local lsp_util = require("lspconfig.util")
local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "cs" }

opts.init_options = {
  AutomaticWorkspaceInit = true,
}
opts.root_dir = lsp_util.root_pattern("*.sln", "*.csproj", "*.fsproj", ".git")

return util.set_on_setup(opts)
