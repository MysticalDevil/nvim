-- Auto install lazy.nvim
local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("lazt.nvim is being installed, please wait..", "info")
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("lazy.nvim not install", "error")
  return
end

lazy.setup({
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  --
  ----------------------------------------- Colorscheme -----------------------------------------
  -- material.nvim
  -- Material colorscheme for NeoVim
  --  "marko-cerovac/material.nvim",
  -- onedark.nvim
  -- One dark and light colorscheme for neovim
  {
    "navarasu/onedark.nvim",
    config = function()
      require("configs.plugin.onedark")
    end,
  },
  -- tokyonight.nvim
  -- A clean, dark Neovim theme written in Lua
  --  "folke/tokyonight.nvim",
  -- aurora
  -- 24-bit dark theme for (Neo)vim
  --  "ray-x/aurora",
  --
  --------------------------------------- Common plugins ----------------------------------------
  -- aerial.nvim
  -- Neovim plugin for a code outline window
  {
    "stevearc/aerial.nvim",
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
  -- bufferline.nvim
  -- A snazzy bufferline for Neovim
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "moll/vim-bbye",
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
  -- dotenv.nvim
  -- A minimalist .env support for Neovim
  {
    "ellisonleao/dotenv.nvim",
    config = function()
      require("configs.plugin.dotenv")
    end,
  },
  -- dressing.nvim
  -- Neovim plugin to improve the default vim.ui interfaces
  "stevearc/dressing.nvim",
  -- fidget.nvim
  -- Standalone UI for nvim-lsp progress
  {
    "j-hui/fidget.nvim",
    config = function()
      require("configs.plugin.fidget")
    end,
  },
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
  -- lualine-lsp-progress
  -- LSP Progress lualine componenet
  "arkav/lualine-lsp-progress",
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
  -- nvim-hlslens
  -- Hlsearch Lens for Neovim
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("configs.plugin.hlslens")
    end,
  },
  -- nvim-notify
  -- A fancy, configurable, notification manager for NeoVim
  {
    "rcarriga/nvim-notify",
    config = function()
      require("configs.plugin.nvim-notify")
    end,
  },
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
  -- nvim-tree.lua
  -- A file explorer tree for neovim written in lua
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons", -- optional. for file icons
    version = "nightly", -- optional, updated every week.
    config = function()
      require("configs.plugin.nvim-tree")
    end,
  },
  -- nvim-treesitter
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- require('nvim-tresitter.install').update({ with_sync = true  },
    end,
    dependencies = {
      { "p00f/nvim-ts-rainbow" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "windwp/nvim-ts-autotag" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
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
  -- telescope.nvim
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-env.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    version = "0.1.0",
    config = function()
      require("configs.plugin.telescope")
    end,
  },
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
    config = function()
      require("configs.plugin.toggleterm")
    end,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
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
    config = function()
      require("configs.plugin.zen-mode")
    end,
  },
  --
  --------------------------------------------- Git ---------------------------------------------
  -- gitsigns.nvim
  -- Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.plugin.gitsigns")
    end,
  },
  -- diffview.nvim
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("configs.plugin.diffview")
    end,
  },
  --
  ---------------------------------- Language Server Protocol -----------------------------------
  -- mason.nvim
  -- Portable package manager for Neovim
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
  },
  -- LSP config
  "neovim/nvim-lspconfig",
  -- nvim-lspfuzzy
  -- A Neovim plugin to make the LSP client use FZF
  {
    "ojroques/nvim-lspfuzzy",
    dependencies = {
      { "junegunn/fzf" },
      { "junegunn/fzf.vim" }, -- to enable preview (optional)
    },
    config = function()
      require("configs.plugin.lspfuzzy")
    end,
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
  -- null-ls.nvim
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
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
    config = function()
      require("configs.plugin.symbols-outline")
    end,
  },
  -------------- Complete Engine --------------
  -- coq_nvim
  -- Fast as FUCK nvim completion
  --  "ms-jpq/coq_nvim",
  -- nvim-cmp
  -- A completion plugin for neovim coded in Lua.
  "hrsh7th/nvim-cmp",
  -- Snippet provider
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- Complete Source
  "hrsh7th/cmp-buffer", -- { name = 'buffer' }
  "hrsh7th/cmp-calc", -- { name = 'calc' }
  "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
  "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
  "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }
  "hrsh7th/cmp-path", -- { name = 'path' }
  "hrsh7th/cmp-vsnip",
  -- formatter.nvim
  -- A format runner for Neovim
  "mhartington/formatter.nvim",

  ----------------- UI Import -----------------
  -- lspkind-nvim
  -- vscode-like pictograms for neovim lsp completion items
  "onsails/lspkind-nvim",
  -- lspsage.nvim
  -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI
  --  {
  --   "glepnir/lspsaga.nvim",
  --   branch = "main",
  --   config = function()
  --     require("configs.plugin.lspsaga",
  --   end,
  --  },
  -- navigator.lua
  -- Source code analysis & navigation plugin for Neovim
  {
    "ray-x/navigator.lua",
    dependencies = {
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("configs.plugin.navigator")
    end,
  },

  --------------- Code Snippets ---------------
  -- Common language code snippets
  "rafamadriz/friendly-snippets",

  -------------- Language Import --------------

  -- TypeScript.nvim
  -- A Lua plugin, written in TypeScript, to write TypeScript (Lua optional)
  "jose-elias-alvarez/typescript.nvim",

  -- schemastore.nvim
  -- JSON schemas for Neovim
  "b0o/schemastore.nvim",

  -- rust-tools.nvim
  -- Tools for better development in rust using neovim's builtin lsp
  {
    "simrat39/rust-tools.nvim",
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

  -- nvim-nu
  -- Basic editor support for the nushell language
  {
    "LhKipp/nvim-nu",
    config = function()
      require("configs.plugin.nu")
    end,
  },

  -- go.nvim
  -- Modern Go plugin for Neovim
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" }, -- recommended if need floating window support
    config = function()
      require("configs.plugin.go")
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

  -- vimspector
  -- vimspector - A multi-language debugging system for Vim
  {
    "puremourning/vimspector",
    cmd = {
      "VimspectorInstall",
      "VimspectorUpdate",
    },
    fn = {
      "vimspector#Launch()",
      "vimspector#ToggleBreakpoint",
      "vimspector#Continue",
    },
    config = function()
      require("dap.vimspector")
    end,
  },
})
-- 每次保存 plugins.lua 自动安装插件
-- vim.cmd([[
--     augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile>  | PackerSync
--     augroup end
--   ]])
