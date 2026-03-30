return {
  {
    "vim-test/vim-test",
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vert botright"
    end,
  },
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
