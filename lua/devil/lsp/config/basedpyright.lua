local util = require("devil.lsp.util")
local opts = util.default_configs()

local lsp_util = require("lspconfig.util")

opts.settings = {
  basedpyright = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "openFilesOnly",
      useLibraryCodeForTypes = true,
    },
  },
}

opts.filetypes = { "python" }

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

opts.root_dir = function(fname)
  return lsp_util.root_pattern(unpack(root_files))(fname)
end

opts.single_file_support = true

return opts
