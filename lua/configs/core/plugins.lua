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
    -- Packer 可以管理自己本身
    use("wbthomason/packer.nvim")
    -- Plugin list
    --------------------- colorscheme ---------------------
    -- material
    use("marko-cerovac/material.nvim")
    -- one dark
    use({
      "navarasu/onedark.nvim",
      config = function()
        require("configs.plugin.onedark")
      end,
    })
    -- tokyonight
    use("folke/tokyonight.nvim")
    ------------------- common plugins --------------------
    -- aerial.nvim
    use({
      "stevearc/aerial.nvim",
      config = function()
        require("configs.plugin.aerial")
      end,
    })
    -- beacon.nvim
    use({
      "rainbowhxch/beacon.nvim",
      config = function()
        require("configs.plugin.beacon")
      end,
    })
    -- bufferline.nvim
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
    -- comment.nvim
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("configs.plugin.comment")
      end,
    })
    -- dashboard-nvim
    use({
      "glepnir/dashboard-nvim",
      event = "VimEnter",
      config = function()
        require("configs.plugin.dashboard")
      end,
    })
    -- diffview.nvim
    use({
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.plugin.diffview")
      end,
    })
    -- dotenv.nvim
    use({
      "ellisonleao/dotenv.nvim",
      config = function()
        require("configs.plugin.dotenv")
      end,
    })
    -- fidget.nvim
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("configs.plugin.fidget")
      end,
    })
    -- hydra.nvim
    -- use({
    --   "anuvyklack/hydra.nvim",
    --   config = function()
    --     require("configs.plugin.hydra")
    --   end,
    -- })
    -- icon-picker.nvim
    use("stevearc/dressing.nvim")
    use({
      "ziontee113/icon-picker.nvim",
      config = function()
        require("configs.plugin.icon-picker")
      end,
    })
    -- indent-blankline.nvim
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("configs.plugin.indent-blankline")
      end,
    })
    -- lualine.nvim
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
    -- neoscroll.nvim
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("configs.plugin.neoscroll")
      end,
    })
    -- nvim-autopairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.plugin.nvim-autopairs")
      end,
    })
    -- nvim-colorizer.lua
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("configs.plugin.nvim-colorizer")
      end,
    })
    -- nvim-notify
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("configs.plugin.nvim-notify")
      end,
    })
    -- nvim-regexplainer
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
    use({
      "petertriho/nvim-scrollbar",
      config = function()
        require("configs.plugin.scrollbar")
      end,
    })
    -- nvim-surrond
    use({
      "kylechui/nvim-surround",
      config = function()
        require("configs.plugin.nvim-surround")
      end,
    })
    -- nvim-test
    use({
      "klen/nvim-test",
      config = function()
        require("configs.plugin.nvim-test")
      end,
    })
    -- nvim-tree.lua
    use({
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons", -- optional. for file icons
      tag = "nightly", -- optional, updated every week.
      config = function()
        require("configs.plugin.nvim-tree")
      end,
    })
    -- nvim-treesitter
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
    use({
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("configs.plugin.nvim-treesitter-context")
      end,
    })
    -- project.nvim
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("configs.plugin.project")
      end,
    })
    -- renamer.nvim
    use({
      "filipdutescu/renamer.nvim",
      branch = "master",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("configs.plugin.renamer")
      end,
    })
    use("arkav/lualine-lsp-progress")
    -- telescope.nvim
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
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
             cmake --build build --config Release && \
             cmake --install build --prefix build",
    })
    -- todo-comments.nvim
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.plugin.todo-comments")
      end,
    })
    -- toggleterm.nvim
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("configs.plugin.toggleterm")
      end,
    })
    -- trouble.nvim
    use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("configs.plugin.trouble")
      end,
    })
    -- urlview.nvim
    use({
      "axieax/urlview.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = function()
        require("configs.plugin.urlview")
      end,
    })
    -- which-key.nvim
    use({
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("configs.plugin.which-key")
      end,
    })
    -- zen-mode.nvim
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("configs.plugin.zen-mode")
      end,
    })
    --
    ------------------------- LSP -------------------------
    -- installer
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- LSP config
    use("neovim/nvim-lspconfig")
    -- 让 LSP 客户端使用 FZF
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
    -- 提供 LSP 树状图
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("configs.plugin.symbols-outline")
      end,
    })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- Snippet 引擎
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' }
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    -- 常见语言代码段
    use("rafamadriz/friendly-snippets")
    -- UI 增强
    use("onsails/lspkind-nvim")
    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require("configs.plugin.lspsage")
      end,
    })
    -- 代码格式化
    use("mhartington/formatter.nvim")
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim",
    })
    -- TypeScript 增强
    use({
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      requires = "nvim-lua/plenary.nvim",
    })
    use("jose-elias-alvarez/typescript.nvim")
    -- Lua 增强
    use("folke/neodev.nvim")
    -- JSON 增强
    use("b0o/schemastore.nvim")
    -- Rust 增强
    use("simrat39/rust-tools.nvim")
    -- nushell 支持
    use({
      "LhKipp/nvim-nu",
      config = function()
        require("configs.plugin.nu")
      end,
    })
    -- golang 支持
    use({
      "ray-x/go.nvim",
      requires = { "ray-x/guihua.lua" }, -- recommended if need floating window support
      config = function()
        require("configs.plugin.go")
      end,
    })
    -------------------------------------------------------
    -- git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("configs.plugin.gitsigns")
      end,
    })
    -- vimspector
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
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")

    -- node
    use({
      "mxsdev/nvim-dap-vscode-js",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dap.nvim-dap.config.vscode-js")
      end,
    })

    -- go
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
