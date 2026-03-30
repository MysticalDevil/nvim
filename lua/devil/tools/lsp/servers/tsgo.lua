---@type vim.lsp.Config
return {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" }, -- "none" | "literals" | "all"
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
