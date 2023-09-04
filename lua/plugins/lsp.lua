return {
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
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
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
    lazy = true,
  },
  ------------------ Formatter and Linter ------------------
  -- null-ls.nvim
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- formatter.nvim
  -- A format runner for Neovim
  {
    "mhartington/formatter.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  -- nvim-lint
  -- An asynchronous linter plugin for Neovim complementary to
  -- the built-in Language Server Protocol support.
  {
    "mfussenegger/nvim-lint",
    dependencies = { "williamboman/mason.nvim" },
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
  { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" }, -- { name = 'cmdline' }
  { "hrsh7th/cmp-nvim-lsp", lazy = true }, -- { name = nvim_lsp p
  { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true }, -- { name = 'nvim_lsp_signature_help' }
  { "hrsh7th/cmp-path", lazy = true }, -- { name = 'path' }
  { "hrsh7th/cmp-vsnip", lazy = true },
  { "PaterJason/cmp-conjure", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "petertriho/cmp-git", lazy = true },

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
    ft = { "python" },
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = function()
      require("configs.plugin.venv-selector")
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },

  -- go.nvim
  -- Modern Go plugin for Neovim
  { "ray-x/guihua.lua", lazy = true },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("configs.plugin.flutter-tools")
    end,
  },

  -- typescript-tools.nvim
  -- TypeScript integration NeoVim deserves
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("configs.plugin.typescript-tools")
    end,
  },

  -- hashell-tools.nvim
  -- Supercharge your Haskell experience in neovim!
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- Optional
    },
    branch = "2.x.x", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      require("configs.plugin.haskell-tools")
    end,
  },

  -- elixir-tools.nvim
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "elixir", "eelixir", "heex", "surface" },
    config = function()
      require("configs.plugin.elixir-tools")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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
  ----------------------------------- Debug Adapter Protocol ------------------------------------
  -- nvim-dap
  -- Debug Adapter Protocol client implementation for Neovim
  { "mfussenegger/nvim-dap", lazy = true },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
  },

  -- nvim-dap-python
  -- An extension for nvim-dap, providing default configurations for python
  -- and methods to debug individual test methods or classes.
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
  },

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

  ------------------- Helpers -------------------
  -- symbols-outline.nvim
  -- A tree like view for symbols in Neovim using the Language Server Protocol
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = function()
      require("configs.plugin.symbols-outline")
    end,
  },
  -- nvim-code-action-menu
  -- Pop-up menu for code actions to show meta-information and diff preview
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
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
  -- aerial.nvim
  -- Neovim plugin for a code outline window
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    config = function()
      require("configs.plugin.aerial")
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
}
