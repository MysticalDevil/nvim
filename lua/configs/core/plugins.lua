-- Auto install Packer.nvim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Packer.nvim is being installed, please wait...")
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
  vim.notify("Packer.nvim installed")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer.nvim not install")
  return
end

packer.startup({
  function(use)
    -- Packer.nvim
    -- A use-package inspired plugin manager for Neovim
    use("wbthomason/packer.nvim")
    -- Plugin list
    --------------------- colorscheme ---------------------
    -- material.nvim
    -- Material colorscheme for NeoVim
    use("marko-cerovac/material.nvim")
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
    use("folke/tokyonight.nvim")
    -- aurora
    -- 24-bit dark theme for (Neo)vim
    use("ray-x/aurora")
    ------------------- common plugins --------------------
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
    -- lsp_signature.nvim
    -- LSP signature hint as you type
    use({
      "ray-x/lsp_signature.nvim",
      -- config = function()
      --   require("configs.plugin.lsp_signature")
      -- end,
    })
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
    -- project.nvim
    -- The superior project management solution for neovim
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("configs.plugin.project")
      end,
    })
    -- renamer.nvim
    -- VS Code-like renaming UI for Neovim, writen in Lua
    use({
      "filipdutescu/renamer.nvim",
      branch = "master",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("configs.plugin.renamer")
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
    -- telescope-fzf-native.nvim
    -- FZF sorter for telescope written in c
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
             cmake --build build --config Release && \
             cmake --install build --prefix build",
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
    -- urlview.nvim
    -- Neovim plugin for viewing all the URLs in a buffer
    use({
      "axieax/urlview.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = function()
        require("configs.plugin.urlview")
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
    ------------------------- LSP -------------------------
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
    -- symbols-outline.nvim
    -- A tree like view for symbols in Neovim using the Language Server Protocol
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("configs.plugin.symbols-outline")
      end,
    })
    -- nvim-cmp
    -- A completion plugin for neovim coded in Lua.
    use("hrsh7th/nvim-cmp")
    -- Snippet provider
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- Complete Source
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' }
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    -- Common language code snippets
    use("rafamadriz/friendly-snippets")
    -- lspkind-nvim
    -- vscode-like pictograms for neovim lsp completion items
    use("onsails/lspkind-nvim")
    -- lspsage.nvim
    -- A lightweight LSP plugin based on Neovim's built-in LSP with a highly performant UI
    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require("configs.plugin.lspsage")
      end,
    })
    -- formatter.nvim
    -- A format runner for Neovim
    use("mhartington/formatter.nvim")
    -- null-ls.nvim
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim",
    })
    -- TypeScrit.nvim
    -- A Lua plugin, written in TypeScript, to write TypeScript (Lua optional)
    use("jose-elias-alvarez/typescript.nvim")
    -- neodev.nvim
    -- Neovim setup for init.lua and plugin development with full signature help,
    -- docs and completion for the nvim lua API
    use("folke/neodev.nvim")
    -- schemastore.nvim
    -- JSON schemas for Neovim
    use("b0o/schemastore.nvim")
    -- rust-tools.nvim
    -- Tools for better development in rust using neovim's builtin lsp
    use("simrat39/rust-tools.nvim")
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
    -------------------------------------------------------
    -- gitsigns.nvim
    -- Git integration for buffers
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("configs.plugin.gitsigns")
      end,
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
    -------------------------------------------------------
    -- nvim-dap
    -- Debug Adapter Protocol client implementation for Neovim
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")

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
    use("leoluz/nvim-dap-go")

    if packer_bootstrap then
      packer.sync()
    end
  end,
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
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>  | PackerSync
    augroup end
  ]]
)
