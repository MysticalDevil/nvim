local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- Plugin list
    ---------------- colorscheme ----------------
    -- one dark pro
    use 'olimorris/onedarkpro.nvim'
    ------------------ plugins ------------------
    -- nvim-tree
    use { 
      'nvim-tree/nvim-tree.lua',
      requires = 'nvim-tree/nvim-web-devicons', -- optional. for file icons
      tag = 'nightly' -- optional, updated every week.
    }
    -- bufferline
    use {
      'akinsho/bufferline.nvim',
      requires = {
        'nvim-tree/nvim-web-devicons',
        'moll/vim-bbye'
      },
      tag = 'v3.*',
    }
    -- lualine
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'nvim-tree/nvim-web-devicons',
        opt = true
      }
    }
    use 'arkav/lualine-lsp-progress'
    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      tag = '0.1.0',
    }
    -- telescope extensions
    use 'LinArcX/telescope-env.nvim'
    -- project
    use 'ahmedkhalf/project.nvim'
    -- dashboard-nvim
    use 'glepnir/dashboard-nvim'
    -- nvim-treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate"
    }
    ------------------ LSP ----------------------
    -- installer
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- Lsp config
    use 'neovim/nvim-lspconfig'
  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
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
