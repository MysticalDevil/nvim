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
    ---------------- colorscheme ----------------
    -- one dark
    use({
      "navarasu/onedark.nvim",
      config = function()
        require("configs.onedark")
      end,
    })
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- material
    use("marko-cerovac/material.nvim")
    ------------------ plugins ------------------
    -- nvim-notify
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("configs.nvim-notify")
      end,
    })
    -- nvim-tree
    use({
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons", -- optional. for file icons
      tag = "nightly", -- optional, updated every week.
      config = function()
        require("configs.nvim-tree")
      end,
    })
    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye",
      },
      tag = "v3.*",
      config = function()
        require("configs.bufferline")
      end,
    })
    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        opt = true,
      },
      config = function()
        require("configs.lualine")
      end,
    })
    use("arkav/lualine-lsp-progress")
    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "LinArcX/telescope-env.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      tag = "0.1.0",
      config = function()
        require("configs.telescope")
      end,
    })
    -- telescope fzf plugin
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
             cmake --build build --config Release && \
             cmake --install build --prefix build",
    })
    -- project
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("configs.project")
      end,
    })
    -- dashboard-nvim
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("configs.dashboard")
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
        require("configs.nvim-treesitter")
      end,
    })
    -- indent-blankline
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("configs.indent-blankline")
      end,
    })
    -- toggleterm
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("configs.toggleterm")
      end,
    })
    -- nvim-surrond
    use({
      "kylechui/nvim-surround",
      config = function()
        require("configs.nvim-surround")
      end,
    })
    -- Comment
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("configs.comment")
      end,
    })
    -- nvim-autopairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.nvim-autopairs")
      end,
    })
    -- fidget.nvim
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("configs.fidget")
      end,
    })
    -- todo-comments.nvim
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.todo-comments")
      end,
    })
    -- zen mode
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("configs.zen-mode")
      end,
    })
    -- nvim-colorizer.lua
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("configs.nvim-colorizer")
      end,
    })
    -- icon-picker.nvim
    use("stevearc/dressing.nvim")
    use({
      "ziontee113/icon-picker.nvim",
      config = function()
        require("configs.icon-picker")
      end,
    })
    --
    ------------------ LSP ----------------------
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
        require("configs.lspfuzzy")
      end,
    })
    -- 提供 LSP 树状图
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("configs.symbols-outline")
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
    use("tami5/lspsaga.nvim")
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
        require("configs.nu")
      end,
    })
    ---------------------------------------------
    -- git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("configs.gitsigns")
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
    ---------------------------------------------
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
