local utils = require("devil.utils")

return {
  --------------------------------------------- Git ---------------------------------------------
  -- diffview.nvim
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- gitsigns.nvim
  -- Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = "BufReadPre",
    init = function()
      utils.load_mappings("gitsigns")
    end,
    opts = require("devil.plugins.configs.gitsigns"), ---@diagnostic disable-line
  },
  -- neogit
  -- magit for neovim
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
  },
}
