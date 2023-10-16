local util = require("lsp.util")
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
  require("lspconfig.util").root_pattern("pubspec.yaml")(fname)
end

return util.set_on_setup(opts)
