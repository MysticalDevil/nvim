---@type vim.lsp.Config
return {
  settings = {
    dart = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {},
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
      updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
      enableSdkFormatter = true,
    },
  },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
}
