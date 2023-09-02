local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("lazy.nvim not install", "error")
  return
end

local plugins_list = {
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  --
  ----------------------------------------- Colorscheme -----------------------------------------
  -- catppuccin
  -- Soothing pastel theme for (Neo)vim
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    config = function()
      require("configs.colorscheme.catppuccin")
    end,
  },
  -- gruvbox.nvim
  -- Lua port of the most famous vim colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.gruvbox")
    end,
  },
  -- kanagawa.nvim
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.kanagawa")
    end,
  },
  -- material.nvim
  -- Material colorscheme for NeoVim
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.material")
    end,
  },
  -- nightfox.nvim
  -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nightfox")
    end,
  },
  -- nord.nvim
  -- An arctic, north-bluish clean and elegant Neovim theme.
  {
    "gbprod/nord.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nord")
    end,
  },
  -- nordic.nvim
  --  Nord for Neovim, but warmer and darker. Supports a variety of plugins and other platforms.
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nordic")
    end,
  },
  -- onedark.nvim
  -- One dark and light colorscheme for neovim
  {
    "navarasu/onedark.nvim",
    lazy = false,
    proiority = 1000,
    config = function()
      require("configs.colorscheme.onedark")
    end,
  },
  -- onedarkpro.nvim
  --  Atom's iconic One Dark theme, for Neovim. Fully customisable, with Treesitter,
  --  LSP semantic token support and a light variant
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.onedarkpro")
    end,
  },
  -- tokyonight.nvim
  -- A clean, dark Neovim theme written in Lua
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.tokyonight")
    end,
  },
  --
  --------------------------------------- Common plugins ----------------------------------------
  -- aerial.nvim
  -- Neovim plugin for a code outline window
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = function()
      require("configs.plugin.aerial")
    end,
  },
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
  -- fidget.nvim
  -- Standalone UI for nvim-lsp progress
  {
    "j-hui/fidget.nvim",
    config = function()
      require("configs.plugin.fidget")
    end,
    tag = "legacy",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.plugin.flash")
    end,
  },
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
  -- nvim-code-action-menu
  -- Pop-up menu for code actions to show meta-information and diff preview
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
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
  -- nvim-navbuddy
  -- A simple popup display that provides breadcrumbs feature using LSP server
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("configs.plugin.navbuddy")
    end,
  },
  -- nvim-navic
  -- Simple winbar/statusline plugin that shows your current code context
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("configs.plugin.navic")
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
  "equalsraf/neovim-gui-shim",
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
    },
    version = "0.1.x",
    config = function()
      require("configs.plugin.telescope")
    end,
  },
  -- telescope-env.nvim
  -- watch environment variables with telescope
  { "LinArcX/telescope-env.nvim", lazy = true },
  -- telescope-ui-select.nvim
  -- It sets vim.ui.select to telescope.
  { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
  -- telescope-fzf-native,nvim
  -- FZF sorter for telescope written in c
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  -- telescope-file-browser.nvim
  -- File Browser extension for telescope.nvim
  { "nvim-telescope/telescope.nvim", lazy = true },
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
  --
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
    config = function()
      require("configs.plugin.gitsigns")
    end,
  },
  -- neogit
  -- magit for neovim
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("configs.plugin.neogit")
    end,
  },
  -- git-conflict.nvim
  -- A plugin to visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("configs.plugin.git-conflict")
    end,
  },

  ---------------------------------- Language Server Protocol -----------------------------------
  -- nvim-lspconfig
  -- Quickstart configs for Nvim LSP
  { "neovim/nvim-lspconfig", proiority = 1000 },
  -- mason.nvim
  -- Portable package manager for Neovim
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-lint",
      "mhartington/formatter.nvim",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
  },
  -- neodev.nvim
  -- Neovim setup for init.lua and plugin development with full signature help,
  -- docs and completion for the nvim lua API
  {
    "folke/neodev.nvim",
    config = function()
      require("configs.plugin.neodev")
    end,
  },
  -- nlsp-settings.nvim
  -- A plugin for setting Neovim LSP with JSON or YAML files
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  -- lsp-zero.nvim
  -- A starting point to setup some lsp related features in neovim.
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { -- Optional
        "williamboman/mason.nvim",
        build = function()
          vim.cmd("MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
    },
  },

  -- efmls-configs-nvim
  -- An unofficial collection of linters and formatters configured for efm-langserver for neovim.
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    dependencies = { "neovim/nvim-lspconfig" },
  },
  ------------------ Formatter ------------------
  -- formatter.nvim
  -- A format runner for Neovim
  {
    "mhartington/formatter.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  ------------------- Linter --------------------
  -- nvim-lint
  -- An asynchronous linter plugin for Neovim complementary to
  -- the built-in Language Server Protocol support.
  {
    "mfussenegger/nvim-lint",
    dependencies = { "williamboman/mason.nvim" },
  },

  ------------------- Helpers -------------------
  -- lsp_signature.nvim
  -- LSP signature hint as you type
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("configs.plugin.lsp_signature")
    end,
  },
  -- symbols-outline.nvim
  -- A tree like view for symbols in Neovim using the Language Server Protocol
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = function()
      require("configs.plugin.symbols-outline")
    end,
  },
  -------------- Complete Engine --------------
  -- nvim-cmp
  -- A completion plugin for neovim coded in Lua.
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
  },
  -- LuaSnip
  -- Snippet Engine for Neovim written in Lua.
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  -- friendly-snippets
  -- Set of preconfigured snippets for different languages.
  { "rafamadriz/friendly-snippets", lazy = true },
  -- Complete Source
  { "hrsh7th/cmp-buffer", lazy = true }, -- { name = 'buffer' }
  { "hrsh7th/cmp-calc", lazy = true }, -- { name = 'calc' }
  { "hrsh7th/cmp-cmdline", lazy = true }, -- { name = 'cmdline' }
  { "hrsh7th/cmp-nvim-lsp", lazy = true }, -- { name = nvim_lsp p
  { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true }, -- { name = 'nvim_lsp_signature_help' }
  { "hrsh7th/cmp-path", lazy = true }, -- { name = 'path' }
  { "hrsh7th/cmp-vsnip", lazy = true },
  { "PaterJason/cmp-conjure", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },

  ----------------- UI Import -----------------
  -- lspkind.nvim
  -- vscode-like pictograms for neovim lsp completion items
  {
    "onsails/lspkind-nvim",
    config = function()
      require("configs.plugin.lspkind")
    end,
  },
  -- lspsage.nvim
  -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI
  {
    "nvimdev/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("configs.plugin.lspsaga")
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  -- navigator.lua
  -- Source code analysis & navigation plugin for Neovim
  -- {
  --   "ray-x/navigator.lua",
  --   dependencies = {
  --     { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  --     { "neovim/nvim-lspconfig" },
  --   },
  --   config = function()
  --     require("configs.plugin.navigator")
  --   end,
  -- },

  -------------- Language Import --------------

  -- schemastore.nvim
  -- JSON schemas for Neovim
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
    lazy = true,
  },

  -- rust-tools.nvim
  -- Tools for better development in rust using neovim's builtin lsp
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("configs.plugin.rust-tools")
    end,
  },
  -- crates.nvim
  -- A neovim plugin that helps managing crates.io dependencies
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.plugin.crates")
    end,
  },

  -- venv-selector.nvim
  -- Allows selection of python virtual environment from within neovim
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = function()
      require("configs.plugin.venv-selector")
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      {
        "<leader>vs",
        "<cmd>:VenvSelect<cr>",
        -- optional if you use a autocmd (see #🤖-Automate)
        "<leader>vc",
        "<cmd>:VenvSelectCached<cr>",
      },
    },
  },

  -- go.nvim
  -- Modern Go plugin for Neovim
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("configs.plugin.go")
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- flutter-tools.nvim
  -- Tools to help create flutter apps in neovim using the native lsp
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.plugin.flutter")
    end,
  },

  -- typescript-tools.nvim
  --
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("configs.plugin.typescript")
    end,
  },

  -- conjure
  --Interactive evaluation for Neovim (Clojure, Fennel, Janet, Racket, Hy, MIT Scheme, Guile)
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "hy", "scheme" }, -- etc
    -- [Optional] cmp-conjure for cmp
    dependencies = {
      "PaterJason/cmp-conjure",
    },
    config = function(_, _)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = true
    end,
  },
  --
  ----------------------------------- Debug Adapter Protocol ------------------------------------
  -- nvim-dap
  -- Debug Adapter Protocol client implementation for Neovim
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",

  -- nvim-dap-vscode-js
  -- nvim-dap adapter for vscode-js-debug
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap.nvim-dap.config.vscode-js")
    end,
  },
  -- nvim-dap-go
  -- An extension for nvim-dap providing configurations for
  -- launching go debugger (delve) and debugging individual tests
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}

local opts = {
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
}

lazy.setup(plugins_list, opts)
