local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_extend("keep", util.default_configs(), {
  setting = {
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
  },
  single_file_support = false,
})
