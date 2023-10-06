local lsp_util = require("lspconfig.util")
local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "fennel" }
opts.root_dir = lsp_util.root_pattern("fnl")
opts.settings = {
  fennel = {
    workspace = {
      -- If you are using hotpot.nvim or aniseed,
      -- make the server aware of neovim runtime files.
      library = vim.api.nvim_list_runtime_paths(),
    },
    diagnostics = {
      globals = { "vim" },
    },
  },
}
opts.single_file_support = true

return util.set_on_setup(opts)
