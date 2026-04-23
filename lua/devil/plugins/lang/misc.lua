return {
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    config = function()
      require("java").setup({
        jdtls = { version = "1.54.0" },
      })
      vim.lsp.config("jdtls", {
        settings = {
          java = {
            inlayHints = {
              parameterNames = { enabled = "all", exclusions = { "this" } },
              variableTypes = { enabled = true },
              parameterTypes = { enabled = true },
            },
          },
        },
      })
    end,
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
        },
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    event = "BufRead CMakeLists.txt",
    ft = { "cmake" },
    opts = {},
  },
  {
    "Mythos-404/xmake.nvim",
    version = "^3",
    lazy = true,
    event = "BufReadPost",
    cmd = "Xmake",
    dependencies = { "folke/lazydev.nvim" },
    config = true,
  },
}
