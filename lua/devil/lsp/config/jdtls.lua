---@type vim.lsp.Config
return {
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },

      compile = {
        nullAnalysis = {
          mode = "automatic",
        },
      },

      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
    },
  },
}
