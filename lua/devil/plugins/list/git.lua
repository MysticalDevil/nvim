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
    init = function()
      utils.load_mappings("gitsigns")
    end,
    opts = function()
      return require("devil.plugins.configs.gitsigns")
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
    opts = function()
      require("devil.plugins.configs.neogit")
    end,
  },
  -- git-conflict.nvim
  -- A plugin to visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = "copen", -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
  },
}
