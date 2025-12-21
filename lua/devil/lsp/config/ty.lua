local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_config("keep", util.default_configs(), {
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
})
