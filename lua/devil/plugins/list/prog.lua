return {
  ---------------------------------- Language Server Protocol -----------------------------------
  --

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
      "stevearc/conform.nvim",
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
    ft = { "lua" },
    opts = require("devil.plugins.configs.neodev"), ---@diagnostic disable-line
  },
  -- nlsp-settings.nvim
  -- A plugin for setting Neovim LSP with JSON or YAML files
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },

  --
  ------------------------------------- Formatter and Linter --------------------------------------
  --

  -- conform.nvim
  -- Lightweight yet powerful formatter plugin for Neovim
  { "stevearc/conform.nvim" },
  { "zapling/mason-conform.nvim" },

  -- nvim-lint
  -- An asynchronous linter plugin for Neovim complementary to
  -- the built-in Language Server Protocol support.
  { "mfussenegger/nvim-lint" },

  --
  ---------------------------------------- Complete Engine ----------------------------------------
  --

  -- nvim-cmp
  -- A completion plugin for neovim coded in Lua.
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      {
        "garymjr/nvim-snippets",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
          create_cmp_source = true,
          friendly_snippets = true,
        },
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-emoji",
        "FelipeLema/cmp-async-path",
        "petertriho/cmp-git",
        "Dosx001/cmp-commit",
        "ray-x/cmp-treesitter",
        "David-Kunz/cmp-npm",
      },
    },
  },

  --
  ---------------------------------------- Language Improve ---------------------------------------
  --

  -------------------- JSON ---------------------
  -- schemastore.nvim
  -- JSON schemas for Neovim
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
    lazy = true,
  },

  -------------------- Rust ---------------------
  -- rustaceanvim
  -- Supercharge your Rust experience in Neovim! A heavily modified fork of rust-tools.nvim
  {
    "mrcjkb/rustaceanvim",
    version = "^7", -- Recommended
    ft = { "rust" },
  },

  -- crates.nvim
  -- A neovim plugin that helps managing crates.io dependencies
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      src = {
        coq = {
          enabled = true,
          name = "crates.nvim",
        },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },

  ------------------- Python --------------------
  -- venv-selector.nvim
  -- Allows selection of python virtual environment from within neovim
  {
    "linux-cultist/venv-selector.nvim",
    ft = { "python" },
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    branch = "main",
    opts = require("devil.plugins.configs.venv-selector"),
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },

  --------------------- Go ----------------------
  -- go.nvim
  -- Modern Go plugin for Neovim
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = function()
      require("go.install").update_all_sync()
    end, -- if you need to install/update all binaries
    opts = require("devil.plugins.configs.go"),
    config = function(_, opts)
      require("go").setup(opts)
      -- Run gofmt + goimport on save
      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
  },

  -------------------- C/C++ --------------------
  -- cmake-tools.nvim
  -- CMake integration in Neovim
  {
    "Civitasv/cmake-tools.nvim",
    event = "BufRead CMakeLists.txt",
    ft = { "cmake" },
    opts = require("devil.plugins.configs.cmake-tools"),
  },

  ------------------- Flutter -------------------
  -- flutter-tools.nvim
  -- Tools to help create flutter apps in neovim using the native lsp
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = require("devil.plugins.configs.flutter-tools"),
  },

  ----------------- TypeScript ------------------
  -- package-info.nvim
  -- All the npm/yarn/pnpm commands I don't want to type
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
        outdated = "#d19a66", -- Text color for outdated dependency virtual text
      },
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = "|  ", -- Icon for up to date dependencies
          outdated = "|  ", -- Icon for outdated dependencies
        },
      },
      autostart = true, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "yarn",
    },
    event = "BufRead package.json",
  },

  -------------------- Yaml ---------------------
  -- yaml.nvim
  -- YAML toolkit for Neovim users
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },

  ----------------------------------- Debug Adapter Protocol ------------------------------------
  -- nvim-dap
  -- Debug Adapter Protocol client implementation for Neovim
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    init = function()
      require("devil.utils").load_mappings("dap")
    end,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "LiadOz/nvim-dap-repl-highlights",
    },
  },

  -- nvim-dap-python
  -- An extension for nvim-dap, providing default configurations for python
  -- and methods to debug individual test methods or classes.
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- nvim-dap-vscode-js
  -- nvim-dap adapter for vscode-js-debug
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("devil.dap.config.vscode-js")
    end,
  },

  -- jbyuki/one-small-step-for-vimkind
  -- Debug adapter for Neovim plugins
  {
    "jbyuki/one-small-step-for-vimkind",
  },

  --
  -------------------------------------------- Helpers --------------------------------------------
  --

  ----------------- UI Improve ------------------
  -- lspkind.nvim
  -- vscode-like pictograms for neovim lsp completion items
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        -- default: true
        -- with_text = true,
        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = "symbol_text",
        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = "default",
        -- override preset symbols
        --
        -- default: {}
        symbol_map = require("devil.utils").kind_icons,
      })
    end,
  },

  ----------------- Grammer Tree ----------------
  -- outline.nvim
  -- Code outline sidebar powered by LSP. Significantly enhanced & refactored fork of symbols-outline.nvim
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle symbols outline tree" },
    },
    opts = require("devil.plugins.configs.outline"),
  },

  -- dropbar.nvim
  -- IDE-like breadcrumbs, out of the box
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = function()
      return require("devil.plugins.configs.dropbar")
    end,
  },

  ------------------ Unit test ------------------
  -- neotest
  -- An extensible framework for interacting with tests within NeoVim.
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",

      -- Languages impl
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
      "lawrence-laz/neotest-zig",
      "sidlatau/neotest-dart",
    },

    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
          require("neotest-plenary"),
          require("neotest-vitest"),
          require("neotest-go"),
          require("neotest-rust"),
          require("neotest-zig"),
          require("neotest-dart"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
        },
      })
    end,
  },

  ----------------- LSP Improve -----------------
  -- fidget.nvim
  -- Standalone UI for nvim-lsp progress
  {
    "j-hui/fidget.nvim",
    opts = function()
      return require("devil.plugins.configs.fidget")
    end,
  },
  -- diagflow.nvim
  -- LSP diagnostics in virtual text at the top right of your screen
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach", -- This is what I use personnally and it works great
    opts = require("devil.plugins.configs.diagflow"),
  },
  -- action-preview.nvim
  -- Fully customizable previewer for LSP code actions.
  {
    "aznhe21/actions-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      return require("devil.plugins.configs.actions-preview")
    end,
  },
  -- nvim-docs-view
  -- A neovim plugin to display lsp hover documentation in a side panel.
  {
    "amrbashir/nvim-docs-view",
    cmd = { "DocsViewToggle" },
    config = function()
      require("docs-view").setup({
        position = "bottom",
        width = 60,
      })
    end,
  },

  -- lsp_signature.nvim
  -- LSP signature hint as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
  },

  -- symbol-useage.nvim
  -- Display references, definitions and implementations of document symbols
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    opts = function()
      return require("devil.plugins.configs.symbol-usage")
    end,
  },

  -- inc-rename.nvim
  -- Incremental LSP renaming based on Neovim's command-preview feature
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    keys = {
      {
        "<leader>rn",
        ":IncRename ",
        desc = "Rename symbols",
      },
    },
    opts = {
      cmd_name = "IncRename", -- the name of the command
      -- the highlight group used for highlighting the identifier's new name
      hl_group = "Substitute",
      -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
      preview_empty_name = false,
      show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
      -- the type of the external input buffer to use (the only supported value is currently "dressing")
      input_buffer_type = nil,
      post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
    },
  },
}
