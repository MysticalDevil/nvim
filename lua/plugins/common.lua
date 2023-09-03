return {
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  --
  --------------------------------------- Common plugins ----------------------------------------
  -- beacon.nvim
  -- Neovim plugin to flash cursor when jumps or moves between windows
  {
    "rainbowhxch/beacon.nvim",
    config = function()
      require("configs.plugin.beacon")
    end,
  },
  -- bufdelete.nvim
  -- Delete Neovim buffers without losing window layout
  { "famiu/bufdelete.nvim", lazy = true },
  -- bufferline.nvim
  -- A snazzy bufferline for Neovim
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "famiu/bufdelete.nvim",
    },
    version = "v3.*",
    config = function()
      require("configs.plugin.bufferline")
    end,
  },
  -- Comment.nvim
  -- Smart and powerful comment plugin for neovim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("configs.plugin.comment")
    end,
  },
  -- dashboard-nvim
  -- Fancy and Blazing Fast start screen plugin of neovim
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("configs.plugin.dashboard")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- dial.nvim
  -- enhanced increment/decrement plugin for Neovim.
  {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.plugin.dial")
    end,
  },
  -- dotenv.nvim
  -- A minimalist .env support for Neovim
  {
    "ellisonleao/dotenv.nvim",
    event = "BufRead .env",
    config = function()
      require("configs.plugin.dotenv")
    end,
  },
  -- dressing.nvim
  -- Neovim plugin to improve the default vim.ui interfaces
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  -- glow.nvim
  -- A markdown preview directly in your neovim.
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- hlargs.nvim
  -- Highlight arguments' definitions and usages, using Treesitter
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("configs.plugin.hlargs")
    end,
  },
  -- hydra.nvim
  -- Create custom submodes and menusCreate custom submodes and menus
  {
    "anuvyklack/hydra.nvim",
    config = function()
      require("configs.plugin.hydra")
    end,
  },
  -- icon-picker.nvim
  -- This is a Neovim plugin that helps you pick Nerd Font Icons, Symbols & Emojis
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("configs.plugin.icon-picker")
    end,
  },
  -- impatient.nvim
  -- Improve startup time for Neovim
  "lewis6991/impatient.nvim",
  -- inc-rename.nvim
  -- Incremental LSP renaming based on Neovim's command-preview feature
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("configs.plugin.inc-rename")
    end,
  },
  -- indent-blankline.nvim
  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("configs.plugin.indent-blankline")
    end,
  },
  -- lualine.nvim
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
    config = function()
      require("configs.plugin.lualine")
    end,
  },
  -- neogen
  -- A better annotation generator
  {
    "danymat/neogen",
    config = function()
      require("configs.plugin.neogen")
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  -- neoscroll.nvim
  -- Smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("configs.plugin.neoscroll")
    end,
  },
  -- neo-tree.nvim
  -- Neovim plugin to manage the file system and other tree like structures
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("configs.plugin.neo-tree")
    end,
  },
  -- noice.nvim
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    config = function()
      require("configs.plugin.noice")
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- nui.nvim
  -- UI Component Library for Neovim
  { "MunifTanjim/nui.nvim", lazy = true },
  -- nvim-autopairs
  -- autopairs for neovim written by lua
  {
    "windwp/nvim-autopairs",
    config = function()
      require("configs.plugin.nvim-autopairs")
    end,
  },
  -- nvim-colorizer.lua
  -- The fastest Neovim colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("configs.plugin.nvim-colorizer")
    end,
  },
  -- nvim-web-devicons
  -- lua `fork` of vim-web-devicons for neovim
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- nvim-hlslens
  -- Hlsearch Lens for Neovim
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("configs.plugin.hlslens")
    end,
  },
  -- nvim-neoclip
  -- Clipboard manager neovim plugin with telescope integration
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("neoclip").setup()
    end,
  },
  -- nvim-notify
  -- A fancy, configurable, notification manager for NeoVim
  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      require("configs.plugin.nvim-notify")
    end,
  },
  -- nvim-qt
  -- Neovim client library and GUI
  { "equalsraf/neovim-gui-shim", lazy = true },
  -- nvim-regexplainer
  -- Describe the regexp under the cursor
  {
    "bennypowers/nvim-regexplainer",
    config = function()
      require("configs.plugin.regexplainer")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  -- nvim-scrollbar
  -- Extensible Neovim Scrollbar
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
    },
    config = function()
      require("configs.plugin.scrollbar")
    end,
  },
  -- nvim-surrond
  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    config = function()
      require("configs.plugin.nvim-surround")
    end,
  },
  -- nvim-test
  -- A Neovim wrapper for running tests
  {
    "klen/nvim-test",
    config = function()
      require("configs.plugin.nvim-test")
    end,
  },
  -- nvim-treesitter
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-tresitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-tree-docs",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("configs.plugin.nvim-treesitter")
    end,
  },
  -- nvim-treesitter-context
  -- Show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("configs.plugin.nvim-treesitter-context")
    end,
  },
  -- nvim-ufo
  -- Not UFO in the sky, but an ultra fold in Neovim
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("configs.plugin.nvim-ufo")
    end,
  },
  -- nvim-window-picker
  -- This plugins prompts the user to pick a window and returns the window id of the picked window
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    config = function()
      require("configs.plugin.window-picker")
    end,
  },
  -- overseer.nvim
  -- A task runner and job management plugin for Neovim
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("configs.plugin.overseer")
    end,
  },
  -- painefer-rust
  -- A Rust port of parinfer.
  {
    "eraserhd/parinfer-rust",
    cmd = "ParinferOn",
    run = "cargo build --release",
  },
  -- plenary.nvim
  -- plenary: full; complete; entire; absolute; unqualified.
  -- All the lua functions I don't want to write twice.
  { "nvim-lua/plenary.nvim", lazy = true },
  -- project.nvim
  -- The superior project management solution for neovim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("configs.plugin.project")
    end,
  },
  -- rest.nvim
  -- A fast Neovim http client written in Lua
  {
    "rest-nvim/rest.nvim",
    config = function()
      require("configs.plugin.rest")
    end,
  },
  -- sniprun
  -- A neovim plugin to run lines/blocs of code
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      require("configs.plugin.sniprun")
    end,
  },
  -- sqlite.lua
  -- SQLite LuaJIT binding with a very simple api.
  { "kkharji/sqlite.lua", lazy = true },
  -- ssr.nvim
  -- Treesitter based structural search and replace plugin for Neovim
  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("configs.plugin.ssr")
    end,
  },
  -- styler.nvim
  -- Simple Neovim plugin to set a different colorscheme per filetype.
  {
    "folke/styler.nvim",
    config = function()
      require("configs.plugin.styler")
    end,
  },
  -- telescope.nvim
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-env.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    version = "0.1.x",
    config = function()
      require("configs.plugin.telescope")
    end,
  },
  { "LinArcX/telescope-env.nvim", lazy = true },
  { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  { "nvim-telescope/telescope-project.nvim", lazy = true },
  -- todo-comments.nvim
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("configs.plugin.todo-comments")
    end,
  },
  -- toggleterm.nvim
  -- A neovim lua plugin to help easily manage multiple terminal windows
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("configs.plugin.toggleterm")
    end,
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
    config = function()
      require("configs.plugin.treesj")
    end,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs.plugin.trouble")
    end,
  },
  -- twilight.nvim
  -- Dims inactive portions of the code you're editing using TreeSitter.
  {
    "folke/twilight.nvim",
    config = function()
      require("configs.plugin.twilight")
    end,
  },
  -- urlview.nvim
  -- Neovim plugin for viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("configs.plugin.urlview")
    end,
  },
  -- vim-illuminate
  -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
  -- Tree-sitter, or regex matching
  {
    "RRethy/vim-illuminate",
    config = function()
      require("configs.plugin.illuminate")
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- which-key.nvim
  -- Create key bindings that stick
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("configs.plugin.which-key")
    end,
  },
  -- zen-mode.nvim
  -- Distraction-free coding for Neovim
  {
    "folke/zen-mode.nvim",
    cmd = "Zen",
    config = function()
      require("configs.plugin.zen-mode")
    end,
  },
}