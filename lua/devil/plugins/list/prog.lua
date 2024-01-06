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
      "mhartington/formatter.nvim",
      "stevearc/conform.nvim",
      "nvimtools/none-ls.nvim",
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
      "nvimtools/none-ls.nvim",
    },
  },

  -- neodev.nvim
  -- Neovim setup for init.lua and plugin development with full signature help,
  -- docs and completion for the nvim lua API
  {
    "folke/neodev.nvim",
    ft = { "lua" },
    opts = function()
      return require("devil.plugins.configs.neodev")
    end,
  },
  -- nlsp-settings.nvim
  -- A plugin for setting Neovim LSP with JSON or YAML files
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },

  --
  ------------------------------------- Formatter and Linter --------------------------------------
  --

  -- null-ls.nvim
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- efmls-configs-nvim
  -- An unofficial collection of linters and formatters configured for efm-langserver for neovim.
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = true,
  },

  -- formatter.nvim
  -- A format runner for Neovim
  {
    "mhartington/formatter.nvim",
    enabled = false,
    dependencies = { "williamboman/mason.nvim" },
  },

  -- conform.nvim
  -- Lightweight yet powerful formatter plugin for Neovim
  {
    "stevearc/conform.nvim",
    enabled = false,
  },

  -- nvim-lint
  -- An asynchronous linter plugin for Neovim complementary to
  -- the built-in Language Server Protocol support.
  {
    "mfussenegger/nvim-lint",
    enabled = false,
    dependencies = { "williamboman/mason.nvim" },
  },

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
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
      "FelipeLema/cmp-async-path",
      "PaterJason/cmp-conjure",
      "saadparwaiz1/cmp_luasnip",
      "petertriho/cmp-git",
      "Dosx001/cmp-commit",
      "ray-x/cmp-treesitter",
      "David-Kunz/cmp-npm",
    },
  },
  -- LuaSnip
  -- Snippet Engine for Neovim written in Lua.
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    version = "2.*",
    build = "make install_jsregexp",
  },
  -- friendly-snippets
  -- Set of preconfigured snippets for different languages.
  { "rafamadriz/friendly-snippets" },
  -- Complete Source
  { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
  { "hrsh7th/cmp-nvim-lsp", event = "LspAttach" },
  -- cmp-npm
  -- -- An additional source for nvim-cmp to autocomplete packages and its versions
  {
    "David-Kunz/cmp-npm",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json",
    config = function()
      require("cmp-npm").setup({})
    end,
  },

  -- coq_nvim
  -- Fast as FUCK nvim completion. SQLite, concurrent scheduler, hundreds of hours of optimization.
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    lazy = true,
    enabled = false,
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
      { "neovim/nvim-lspconfig" },
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
  -- rust-tools.nvim
  -- Tools for better development in rust using neovim's builtin lsp
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    lazy = true,
  },
  -- crates.nvim
  -- A neovim plugin that helps managing crates.io dependencies
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
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
    opts = function()
      return require("devil.plugins.configs.venv-selector")
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  -- wookayin/semshi
  -- Semantic Highlighting for Python in Neovim
  {
    "wookayin/semshi", -- use a maintained fork
    ft = "python",
    build = ":UpdateRemotePlugins",
    init = function()
      -- Disabled these features better provided by LSP or other more general plugins
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      -- vim.g["semshi#mark_selected_nodes"] = false

      -- This autocmd must be defined in init to take effect
      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
        callback = function()
          -- Only add style, inherit or link to the LSP's colors
          vim.cmd([[
            highlight! semshiGlobal gui=italic
            highlight! semshiImported gui=bold
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiAttribute @attribute
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
            ]])
        end,
      })
    end,
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
    opts = function()
      return require("devil.plugins.configs.go")
    end,
    config = function(_, opts)
      require("go").setup(opts)
      -- Run gofmt + goimport on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
  },

  -------------------- C/C++ --------------------
  -- clangd_extensions.nvim
  -- Clangd's off-spec features for neovim's LSP client.
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = function()
      return require("devil.plugins.configs.clangd_extensions")
    end,
    config = function(_, opts)
      require("clangd_extensions").setup(opts)

      -- load clangd extensions when clangd attaches
      local augroup = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require("clangd_extensions")
            vim.api.nvim_del_augroup_by_id(augroup)
          end
        end,
      })
    end,
  },
  -- cmake-tools.nvim
  -- CMake integration in Neovim
  {
    "Civitasv/cmake-tools.nvim",
    event = "BufRead CMakeLists.txt",
    ft = { "cmake" },
    opts = function()
      return require("devil.plugins.configs.cmake-tools")
    end,
  },

  ------------------- CSharp --------------------
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "cs", "vb" },
  },

  ------------------ FSharp --------------------
  {
    "ionide/Ionide-vim",
    ft = { "fsharp" },
    build = "make fsautocomplete",
    dependencies = { "neovim/nvim-lspconfig" },
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
    opts = function()
      return require("devil.plugins.configs.flutter-tools")
    end,
  },

  ----------------- TypeScript ------------------
  -- typescript-tools.nvim
  -- TypeScript integration NeoVim deserves
  {
    "pmizio/typescript-tools.nvim",
    lazy = true,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = function()
      return require("devil.plugins.configs.typescript-tools")
    end,
  },
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

  -------------------- Java ---------------------
  -- nvim-jdtls
  -- Extensions for the built-in LSP support in Neovim for eclipse.jdt.l
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("devil.plugins.configs.jdtls")
    end,
  },

  -------------------- Scala --------------------
  -- nvim-metals
  -- A Metals plugin for Neovim
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("devil.plugins.configs.metals")
    end,
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
  { "mfussenegger/nvim-dap", lazy = true },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-repl-highlights").setup()
    end,
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
      require("devil.dap.nvim-dap.config.vscode-js")
    end,
  },

  -- nvim-dap-go
  -- An extension for nvim-dap providing configurations for
  -- launching go debugger (delve) and debugging individual tests
  {
    "leoluz/nvim-dap-go",
    ft = { "go", "gomod" },
    dependencies = { "mfussenegger/nvim-dap" },
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
  -- symbols-outline.nvim
  -- A tree like view for symbols in Neovim using the Language Server Protocol
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    opts = function()
      return require("devil.plugins.configs.symbols-outline")
    end,
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

  ----------------- LSP Improve -----------------
  -- fidget.nvim
  -- Standalone UI for nvim-lsp progress
  {
    "j-hui/fidget.nvim",
    opts = function()
      return require("devil.plugins.configs.fidget")
    end,
  },
  -- lsp_lines.nvim
  -- A simple neovim plugin that renders diagnostics using virtual lines on top of the real line of code.
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    keys = {
      {
        "<Leader>l",
        function()
          require("lsp_lines").toggle()
        end,
        desc = "Toggle lsp_lines",
      },
    },
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
        function()
          return (":IncRename %s"):format(vim.fn.expand("<cword>"))
        end,
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

  ----------------- Tree sitter -----------------
  -- tree-sitter-hypr
  -- hyprland configuration files grammar for treesitter
  { "luckasRanarison/tree-sitter-hypr", event = "VeryLazy" },
}
