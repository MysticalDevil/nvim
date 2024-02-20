local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "dart" }
opts.settings = {
  dart = {
    showTodos = true,
    completeFunctionCalls = true,
    analysisExcludedFolders = {},
    renameFilesWithClasses = "prompt", -- "always"
    enableSnippets = true,
    updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
    enableSdkFormatter = true,
  },
}
opts.init_options = {
  closingLabels = true,
  flutterOutline = true,
  onlyAnalyzeProjectsWithOpenFiles = true,
  outline = true,
  suggestFromUnimportedLibraries = true,
}
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern("pubspec.yaml")(fname)
    or require("lspconfig.util").find_git_ancestor(fname)
end

return opts
