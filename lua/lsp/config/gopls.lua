local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "go", "gomod", "gowork", "gotmpl" }
opts.settings = {
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
    gofumpt = true,
    hints = {
      rangeVariableTypes = true,
      parameterNames = true,
      constantValues = true,
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      functionTypeParameters = true,
    },
  },
}
opts.init_options = {
  usePlaceholders = true,
}
opts.root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git")
opts.single_file_support = true

return util.set_on_setup(opts)
