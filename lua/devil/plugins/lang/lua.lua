return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "lazy.nvim",
        { path = "snacks.nvim", words = { "Snacks" } },
        {
          path = vim.fn.stdpath("data") .. "/lazy/xmake.nvim/addons/en/library",
          files = { "xmake.lua" },
        },
      },
    },
  },
}
