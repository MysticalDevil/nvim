return {
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    config = function()
      require("java").setup({
        jdtls = { version = "1.54.0" },
      })
    end,
  },
  {
    "seblyng/roslyn.nvim",
    opts = {},
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
