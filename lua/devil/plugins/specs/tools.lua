local utils = require("devil.utils")
local others_configs = require("devil.plugins.configs.others")

return {
  -- snacks.nvim
  -- A collection of QoL plugins for Neovim
  {
    "folke/snacks.nvim",
    priority = 1000,
    event = "VeryLazy",
    keys = utils.get_lazy_keys("snacks"),
    opts = require("devil.plugins.configs.snacks"),
  },
  -- smartcolumn.nvim
  -- A Neovim plugin hiding your colorcolumn when unneeded.
  {
    "m4xshen/smartcolumn.nvim",
    opts = others_configs.smartcolumn,
  },
  -- smart-open.nvim
  -- Neovim plugin for fast file-finding
  {
    "danielfalk/smart-open.nvim",
    lazy = true,
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  -- smart-splits.nvim
  -- Smart, seamless, directional navigation and resizing of Neovim +
  -- terminal multiplexer splits. Supports tmux, Wezterm, and Kitty.
  -- Think about splits in terms of "up/down/left/right".
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    version = ">=1.0.0",
    keys = utils.get_lazy_keys("smart_splits"),
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      ignored_buftypes = { "NvimTree" },
      default_amount = 3,
      at_edge = "wrap",
      move_cursor_same_row = false,
      cursor_follows_swapped_bufs = false,
      resize_mode = {
        quit_key = "<ESC>",
        resize_keys = { "h", "j", "k", "l" },
        silent = false,
        hooks = {
          on_enter = nil,
          on_leave = nil,
        },
      },
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
      multiplexer_integration = nil,
      disable_multiplexer_nav_when_zoomed = true,
      kitty_password = nil,
      log_level = "info",
    },
  },
  -- sniprun
  -- A neovim plugin to run lines/blocs of code
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    opts = {
      selected_interpreters = {},
      repl_enable = {},
      repl_disable = {},
      interpreter_options = {
        GFM_original = {
          use_on_filetypes = { "markdown.pandoc" },
        },
        Python3_original = {
          error_truncate = "auto",
        },
      },
      display = {
        "Classic",
        "VirtualTextOk",
        "NvimNotify",
      },
      live_display = { "VirtualTextOk" },
      display_options = {
        terminal_width = 45,
        notification_timeout = 5,
      },
      show_no_output = {
        "Classic",
        "TempFloatingWindow",
      },
      snipruncolors = {
        SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
        SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
        SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
        SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
      },
      live_mode_toggle = "off",
      inline_messages = 0,
      borders = "rounded",
    },
  },
  -- telescope.nvim
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "desdic/agrolens.nvim",

      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    version = "^0.2",
    keys = utils.get_lazy_keys("telescope"),
    opts = function()
      return require("devil.plugins.configs.telescope")
    end,
  },
  -- text-case.nvim
  -- An all in one plugin for converting text case in Neovim
  { "johmsalas/text-case.nvim", lazy = true },
  -- todo-comments.nvim
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = others_configs.todo_comments,
  },
  -- treesj
  -- Neovim plugin for splitting/joining blocks of code
  {
    "Wansmer/treesj",
    cmd = "TSJToggle",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = others_configs.treesj,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-mini/mini.icons",
    keys = utils.get_lazy_keys("trouble"),
    opts = { use_diagnostic_signs = true },
  },
  -- urlview.nvim
  -- Neovim plugin for viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    opts = function()
      return require("devil.plugins.configs.urlview")
    end,
  },
  -- which-key.nvim
  -- Create key bindings that stick
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = utils.get_lazy_keys("whichkey"),
    config = function()
      require("devil.plugins.configs.which-key")
    end,
  },
  -- workspaces.nvim
  -- a simple plugin to manage workspace directories in neovim
  {
    "natecraddock/workspaces.nvim",
    cmd = {
      "WorkspacesAdd",
      "WorkspacesAddDir",
      "WorkspacesRemove",
      "WorkspacesRemoveDir",
      "WorkspacesRename",
      "WorkspacesList",
      "WorkspacesListDirs",
      "WorkspacesOpen",
      "WorkspacesSyncDirs",
    },
    opts = {
      hooks = {
        open = { "Telescope find_files" },
      },
    },
  },
  -- yanky.nvim
  -- Improved Yank and Put functionalities for Neovim
  {
    "gbprod/yanky.nvim",
    keys = utils.get_lazy_keys("yanky"),
    opts = {},
  },
}
