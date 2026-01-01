---@type vim.lsp.Config
return {
  settings = {
    ty = {
      inlayHints = {
        variableTypes = true,
        callArgumentNames = true,
      },
      completions = {
        autoImport = true,
      },
      diagnosticMode = "workspace",
    },
  },
}
