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
    config = function()
      require("devil.configs.plugin.gitsigns")
    end,
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
    config = function()
      require("devil.configs.plugin.neogit")
    end,
  },
  -- git-conflict.nvim
  -- A plugin to visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("devil.configs.plugin.git-conflict")
    end,
  },
}
