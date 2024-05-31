local lsp_util = require("lspconfig.util")
local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "svelte" }
opts.root_dir = function(fname)
  return lsp_util.root_pattern("package.json", ".git")(fname)
end

opts.setting = {
  typescript = {
    inlayHints = {
      parameterNames = { enabled = "all" },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      enumMemberValues = { enabled = true },
    },
  },
}
opts.single_file_support = false

return opts
