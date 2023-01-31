-- Auto install Packer.nvim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Packer.nvim is being installed, please wait...", "info")
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  local rtp_addition = fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimpath = rtp_addition .. "," .. vim.o.runtimpath
  end
  vim.notify("Packer.nvim installed", "info")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer.nvim not install", "warn")
  return
end

packer.startup({
  function(use)
    -- Packer.nvim
    -- A use-package inspired plugin manager for Neovim
    use("wbthomason/packer.nvim")
    --
    ----------------------------------------- Colorscheme -----------------------------------------
    -- material.nvim
    -- Material colorscheme for NeoVim
    -- use("marko-cerovac/material.nvim")
    -- onedark.nvim
    -- One dark and light colorscheme for neovim
    use({
      "navarasu/onedark.nvim",
      config = function()
        require("configs.plugin.onedark")
      end,
    })
    -- tokyonight.nvim
    -- A clean, dark Neovim theme written in Lua
    -- use("folke/tokyonight.nvim")
    -- aurora
    -- 24-bit dark theme for (Neo)vim
    -- use("ray-x/aurora")
    --
    --------------------------------------- Common plugins ----------------------------------------
    -- aerial.nvim
    -- Neovim plugin for a code outline window
    use({
      "stevearc/aerial.nvim",
      config = function()
        require("configs.plugin.aerial")
      end,
    })
    -- beacon.nvim
    -- Neovim plugin to flash cursor when jumps or moves between windows
    use({
      "rainbowhxch/beacon.nvim",
      config = function()
        require("configs.plugin.beacon")
      end,
    })
    -- bufferline.nvim
    -- A snazzy bufferline for Neovim
    use({
      "akinsho/bufferline.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye",
      },
      tag = "v3.*",
      config = function()
        require("configs.plugin.bufferline")
      end,
    })
    -- Comment.nvim
    -- Smart and powerful comment plugin for neovim
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("configs.plugin.comment")
      end,
    })
    -- dashboard-nvim
    -- Fancy and Blazing Fast start screen plugin of neovim
    use({
      "glepnir/dashboard-nvim",
      event = "VimEnter",
      config = function()
        require("configs.plugin.dashboard")
      end,
      requires = { "nvim-tree/nvim-web-devicons" },
    })
    -- dotenv.nvim
    -- A minimalist .env support for Neovim
    use({
      "ellisonleao/dotenv.nvim",
      config = function()
        require("configs.plugin.dotenv")
      end,
    })
    -- fidget.nvim
    -- Standalone UI for nvim-lsp progress
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("configs.plugin.fidget")
      end,
    })
    -- hydra.nvim
    -- Create custom submodes and menusCreate custom submodes and menus
    use({
      "anuvyklack/hydra.nvim",
      config = function()
        require("configs.plugin.hydra")
      end,
    })
    -- dressing.nvim
    -- Neovim plugin to improve the default vim.ui interfaces
    use("stevearc/dressing.nvim")
    -- icon-picker.nvim
    -- This is a Neovim plugin that helps you pick Nerd Font Icons, Symbols & Emojis
    use({
      "ziontee113/icon-picker.nvim",
      config = function()
        require("configs.plugin.icon-picker")
      end,
    })
    -- inc-rename.nvim
    -- Incremental LSP renaming based on Neovim's command-preview feature
    use({
      "smjonas/inc-rename.nvim",
      config = function()
        require("configs.plugin.inc-rename")
      end,
    })
    -- indent-blankline.nvim
    -- Indent guides for Neovim
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("configs.plugin.indent-blankline")
      end,
    })
    -- lualine.nvim
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        opt = true,
      },
      config = function()
        require("configs.plugin.lualine")
      end,
    })
    -- lualine-lsp-progress
    -- LSP Progress lualine componenet
    use("arkav/lualine-lsp-progress")
    -- neoscroll.nvim
    -- Smooth scrolling neovim plugin written in lua
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("configs.plugin.neoscroll")
      end,
    })
    -- noice.nvim
    -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
    use({
      "folke/noice.nvim",
      config = function()
        require("configs.plugin.noice")
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        "nvim-treesitter/nvim-treesitter",
      },
    })
    -- nvim-autopairs
    -- autopairs for neovim written by lua
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.plugin.nvim-autopairs")
      end,
    })
    -- nvim-colorizer.lua
    -- The fastest Neovim colorizer
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("configs.plugin.nvim-colorizer")
      end,
    })
    -- nvim-hlslens
    -- Hlsearch Lens for Neovim
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("configs.plugin.hlslens")
      end,
    })
    -- nvim-notify
    -- A fancy, configurable, notification manager for NeoVim
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("configs.plugin.nvim-notify")
      end,
    })
    -- nvim-regexplainer
    -- Describe the regexp under the cursor
    use({
      "bennypowers/nvim-regexplainer",
      config = function()
        require("configs.plugin.regexplainer")
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "MunifTanjim/nui.nvim",
      },
    })
    -- nvim-scrollbar
    -- Extensible Neovim Scrollbar
    use({
      "petertriho/nvim-scrollbar",
      config = function()
        require("configs.plugin.scrollbar")
      end,
    })
    -- nvim-surrond
    -- Add/change/delete surrounding delimiter pairs with ease
    use({
      "kylechui/nvim-surround",
      config = function()
        require("configs.plugin.nvim-surround")
      end,
    })
    -- nvim-test
    -- A Neovim wrapper for running tests
    use({
      "klen/nvim-test",
      config = function()
        require("configs.plugin.nvim-test")
      end,
    })
    -- nvim-tree.lua
    -- A file explorer tree for neovim written in lua
    use({
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons", -- optional. for file icons
      tag = "nightly", -- optional, updated every week.
      config = function()
        require("configs.plugin.nvim-tree")
      end,
    })
    -- nvim-treesitter
    -- Nvim Treesitter configurations and abstraction layer
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        -- require('nvim-tresitter.install').update({ with_sync = true })
      end,
      requires = {
        { "p00f/nvim-ts-rainbow" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "windwp/nvim-ts-autotag" },
        { "nvim-treesitter/nvim-treesitter-refactor" },
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = function()
        require("configs.plugin.nvim-treesitter")
      end,
    })
    -- nvim-treesitter-context
    -- Show code context
    use({
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("configs.plugin.nvim-treesitter-context")
      end,
    })
    -- nvim-ufo
    -- Not UFO in the sky, but an ultra fold in Neovim
    use({
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
      config = function()
        require("configs.plugin.nvim-ufo")
      end,
    })
    -- project.nvim
    -- The superior project management solution for neovim
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("configs.plugin.project")
      end,
    })
    -- rest.nvim
    -- A fast Neovim http client written in Lua
    use({
      "rest-nvim/rest.nvim",
      config = function()
        require("configs.plugin.rest")
      end,
    })
    -- sniprun
    -- A neovim plugin to run lines/blocs of code
    use({
      "michaelb/sniprun",
      run = "bash ./install.sh",
      config = function()
        require("configs.plugin.sniprun")
      end,
    })
    -- ssr.nvim
    -- Treesitter based structural search and replace plugin for Neovim
    use({
      "cshuaimin/ssr.nvim",
      module = "ssr",
      -- Calling setup is optional.
      config = function()
        require("configs.plugin.ssr")
      end,
    })
    -- telescope.nvim
    -- Find, Filter, Preview, Pick. All lua, all the time.
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "LinArcX/telescope-env.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      tag = "0.1.0",
      config = function()
        require("configs.plugin.telescope")
      end,
    })
    -- todo-comments.nvim
    -- Highlight, list and search todo comments in your projects
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.plugin.todo-comments")
      end,
    })
    -- toggleterm.nvim
    -- A neovim lua plugin to help easily manage multiple terminal windows
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("configs.plugin.toggleterm")
      end,
    })
    -- trouble.nvim
    -- A pretty diagnostics, references, telescope results,
    -- quickfix and location list to help you solve all the trouble your code is causing
    use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("configs.plugin.trouble")
      end,
    })
    -- twilight.nvim
    -- Dims inactive portions of the code you're editing using TreeSitter.
    use({
      "folke/twilight.nvim",
      config = function()
        require("configs.plugin.twilight")
      end,
    })
    -- urlview.nvim
    -- Neovim plugin for viewing all the URLs in a buffer
    use({
      "axieax/urlview.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = function()
        require("configs.plugin.urlview")
      end,
    })
    -- vim-illuminate
    -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP,
    -- Tree-sitter, or regex matching
    use({
      "RRethy/vim-illuminate",
      config = function()
        require("configs.plugin.illuminate")
      end,
    })
    -- which-key.nvim
    -- Create key bindings that stick
    use({
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("configs.plugin.which-key")
      end,
    })
    -- zen-mode.nvim
    -- Distraction-free coding for Neovim
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("configs.plugin.zen-mode")
      end,
    })
    --
    --------------------------------------------- Git ---------------------------------------------
    -- gitsigns.nvim
    -- Git integration for buffers
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("configs.plugin.gitsigns")
      end,
    })
    -- diffview.nvim
    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
    use({
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.plugin.diffview")
      end,
    })
    --
    ---------------------------------- Language Server Protocol -----------------------------------
    -- mason.nvim
    -- Portable package manager for Neovim
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- LSP config
    use("neovim/nvim-lspconfig")
    -- nvim-lspfuzzy
    -- A Neovim plugin to make the LSP client use FZF
    use({
      "ojroques/nvim-lspfuzzy",
      requires = {
        { "junegunn/fzf" },
        { "junegunn/fzf.vim" }, -- to enable preview (optional)
      },
      config = function()
        require("configs.plugin.lspfuzzy")
      end,
    })
    -- neodev.nvim
    -- Neovim setup for init.lua and plugin development with full signature help,
    -- docs and completion for the nvim lua API
    use({
      "folke/neodev.nvim",
      config = function()
        require("configs.plugin.neodev")
      end,
    })
    -- null-ls.nvim
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim",
    })
    -- lsp_signature.nvim
    -- LSP signature hint as you type
    use({
      "ray-x/lsp_signature.nvim",
      config = function()
        require("configs.plugin.lsp_signature")
      end,
    })
    -- symbols-outline.nvim
    -- A tree like view for symbols in Neovim using the Language Server Protocol
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("configs.plugin.symbols-outline")
      end,
    })
    -------------- Complete Engine --------------
    -- coq_nvim
    -- Fast as FUCK nvim completion
    use("ms-jpq/coq_nvim")
    -- nvim-cmp
    -- A completion plugin for neovim coded in Lua.
    use("hrsh7th/nvim-cmp")
    -- Snippet provider
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- Complete Source
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' }
    use("hrsh7th/cmp-calc") -- { name = 'calc' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-vsnip")
    -- formatter.nvim
    -- A format runner for Neovim
    use("mhartington/formatter.nvim")

    ----------------- UI Import -----------------
    -- lspkind-nvim
    -- vscode-like pictograms for neovim lsp completion items
    use("onsails/lspkind-nvim")
    -- lspsage.nvim
    -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI
    -- use({
    --   "glepnir/lspsaga.nvim",
    --   branch = "main",
    --   config = function()
    --     require("configs.plugin.lspsage")
    --   end,
    -- })
    -- navigator.lua
    -- Source code analysis & navigation plugin for Neovim
    use({
      "ray-x/navigator.lua",
      requires = {
        { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
        { "neovim/nvim-lspconfig" },
      },
      config = function()
        require("configs.plugin.navigator")
      end,
    })

    --------------- Code Snippets ---------------
    -- Common language code snippets
    use("rafamadriz/friendly-snippets")

    -------------- Language Import --------------

    -- TypeScript.nvim
    -- A Lua plugin, written in TypeScript, to write TypeScript (Lua optional)
    use("jose-elias-alvarez/typescript.nvim")

    -- schemastore.nvim
    -- JSON schemas for Neovim
    use("b0o/schemastore.nvim")

    -- rust-tools.nvim
    -- Tools for better development in rust using neovim's builtin lsp
    use("simrat39/rust-tools.nvim")
    -- crates.nvim
    -- A neovim plugin that helps managing crates.io dependencies
    use({
      "saecki/crates.nvim",
      tag = "v0.3.0",
      event = { "BufRead Cargo.toml" },
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("configs.plugin.crates")
      end,
    })

    -- nvim-nu
    -- Basic editor support for the nushell language
    use({
      "LhKipp/nvim-nu",
      config = function()
        require("configs.plugin.nu")
      end,
    })

    -- go.nvim
    -- Modern Go plugin for Neovim
    use({
      "ray-x/go.nvim",
      requires = { "ray-x/guihua.lua" }, -- recommended if need floating window support
      config = function()
        require("configs.plugin.go")
      end,
    })

    -- semshi
    -- Semantic Highlighting for Python in Neovim
    use("numirias/semshi")
    --
    ----------------------------------- Debug Adapter Protocol ------------------------------------
    -- nvim-dap
    -- Debug Adapter Protocol client implementation for Neovim
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- nvim-dap-vscode-js
    -- nvim-dap adapter for vscode-js-debug
    use({
      "mxsdev/nvim-dap-vscode-js",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dap.nvim-dap.config.vscode-js")
      end,
    })
    -- nvim-dap-go
    -- An extension for nvim-dap providing configurations for
    -- launching go debugger (delve) and debugging individual tests
    use({
      "leoluz/nvim-dap-go",
      requires = { "mfussenegger/nvim-dap" },
    })

    -- vimspector
    -- vimspector - A multi-language debugging system for Vim
    use({
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
    })

    if packer_bootstrap then
      packer.sync()
    end
  end,
  ------------------------------------- Packer configurations -------------------------------------
  config = {
    -- 锁定插件版本在 snapshots 目录
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 并发数限制
    max_jobs = 4,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
  },
})
-- 每次保存 plugins.lua 自动安装插件
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>  | PackerSync
    augroup end
  ]])
