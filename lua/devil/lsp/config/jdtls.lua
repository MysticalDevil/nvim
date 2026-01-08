---@type vim.lsp.Config
return {
  settings = {
    java = {
      configuration = {
        {
          name = "JavaSE-25",
          path = "/usr/lib/jvm/java-25-openjdk",
          default = true,
        },
        {
          name = "JavaSE-21",
          path = "/usr/lib/jvm/jre-21-openjdk",
        },
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
        signatureHelp = { enabled = true },
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
