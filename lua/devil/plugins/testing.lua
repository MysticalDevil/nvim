return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
      "marilari88/neotest-vitest",
      "lawrence-laz/neotest-zig",
      "sidlatau/neotest-dart",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-python"),
          require("neotest-plenary"),
          require("neotest-vitest"),
          require("neotest-go"),
          require("neotest-zig"),
          require("neotest-dart"),
        },
      }
    end,
  },
}
