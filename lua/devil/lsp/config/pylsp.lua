local util = require("devil.lsp.util")
local opts = util.default_configs()

local lsp_util = require("lspconfig.util")

opts.settings = {
  pylsp = {
    plugins = {
      pycodestyle = {
        ignore = { "W391" },
        maxLineLength = 100,
      },
    },
  },
}

opts.filetypes = { "python" }

opts.root_dir = function(fname)
  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
  }
  return lsp_util.root_pattern(unpack(root_files))(fname) or lsp_util.find_git_ancestor(fname)
end

opts.single_file_support = true

return util.set_on_setup(opts)
