local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "go", "gomod", "gowork", "gotmpl" }
opts.settings = {
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      shadow = true,
      fieldalignment = true,
      nilness = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
    },
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
    codelenses = {
      gc_details = false,
      generate = true,
      regenerate_cgo = true,
      run_govulncheck = true,
      test = true,
      tidy = true,
      upgrade_dependency = true,
      vendor = true,
    },
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
    semanticTokens = true,
  },
}
opts.init_options = {
  usePlaceholders = true,
}
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern("go.work", "go.mod")(fname)
    or require("lspconfig.util").find_git_ancestor(fname)
end
opts.single_file_support = true

return util.set_on_setup(opts)
