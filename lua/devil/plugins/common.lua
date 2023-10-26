return {
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  -- nfnl
  -- Enhance your Neovim with Fennel
  { "Olical/nfnl", ft = "fennel" },

  --
  --------------------------------------- Common plugins ----------------------------------------
  -- agrolens.nvim
  -- Telescope extentions to view pre-defined/custom treesitter queries
  {
    "desdic/agrolens.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  -- beacon.nvim
  -- Neovim plugin to flash cursor when jumps or moves between windows
  {
    "rainbowhxch/beacon.nvim",
    config = function()
      require("devil.configs.plugin.beacon")
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
      require("devil.configs.plugin.bufferline")
    end,
  },
  -- buffer_manager.nvim
  -- A simple plugin to easily manage Neovim buffers.
  {
    "j-morano/buffer_manager.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("devil.configs.plugin.buffer_manager")
    end,
  },
  -- cellular-automaton.nvim
  -- A useless plugin that might help you cope with stubbornly broken tests or overall lack of sense in life.
  -- It lets you execute aesthetically pleasing, cellular automaton animations based on the content of neovim buffer.
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },

  -- codewindow.nvim
  -- Codewindow.nvim is a minimap plugin for neovim, that is closely integrated with treesitter
  -- and the builtin LSP to display more information to the user.
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  -- Comment.nvim
  -- Smart and powerful comment plugin for neovim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("devil.configs.plugin.comment")
    end,
  },
  -- dashboard-nvim
  -- Fancy and Blazing Fast start screen plugin of neovim
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("devil.configs.plugin.dashboard")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- dial.nvim
  -- enhanced increment/decrement plugin for Neovim.
  {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("devil.configs.plugin.dial")
    end,
  },
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup()
    end,
  },
  -- dotenv.nvim
  -- A minimalist .env support for Neovim
  {
    "ellisonleao/dotenv.nvim",
    event = "BufRead .env",
    config = function()
      require("devil.configs.plugin.dotenv")
    end,
  },
  -- dressing.nvim
  -- Neovim plugin to improve the default vim.ui interfaces
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  -- flash.nvim
  -- Navigate your code with search labels, enhanced character motions and Treesitter integration
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("devil.configs.plugin.flash")
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
      require("devil.configs.plugin.hlargs")
    end,
  },
  -- headlines.nvim
  -- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter",
    config = function()
      require("devil.configs.plugin.headlines")
    end,
  },
  -- hlchunk.nvim
  -- This is the lua implementation of nvim-hlchunk, you can use this neovim plugin to
  -- highlight your indent line and the current chunk (context) your cursor stayed
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = "UIEnter",
  --   config = function()
  --     require("devil.configs.plugin.hlchunk")
  --   end,
  -- },
  -- hop.nvim
  -- Neovim motions on speed!
  { "phaazon/hop.nvim", lazy = true, enabled = false },
  -- hydra.nvim
  -- Create custom submodes and menusCreate custom submodes and menus
  {
    "anuvyklack/hydra.nvim",
    config = function()
      require("devil.configs.plugin.hydra")
    end,
    lazy = true,
  },
  -- icon-picker.nvim
  -- This is a Neovim plugin that helps you pick Nerd Font Icons, Symbols & Emojis
  {
    "ziontee113/icon-picker.nvim",
    cmd = {
      "IconPickerYank",
      "IconPickerInsert",
      "IconPickerNormal",
    },
    config = function()
      require("devil.configs.plugin.icon-picker")
    end,
  },
  -- illuminate.vim
  -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either
  -- LSP, Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    config = function()
      require("devil.configs.plugin.illuminate")
    end,
  },
  -- inc-rename.nvim
  -- Incremental LSP renaming based on Neovim's command-preview feature
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    config = function()
      require("devil.configs.plugin.inc-rename")
    end,
  },
  -- indent-blankline.nvim
  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "UIEnter",
    config = function()
      require("devil.configs.plugin.indent-blankline")
    end,
  },
  -- iron.nvim
  -- Interactive Repl Over Neovim
  {
    "Vigemus/iron.nvim",
    cmd = "IronRepl",
    version = "*",
    config = function()
      require("devil.configs.plugin.iron")
    end,
  },
  -- leap.nvim
  -- Neovim's answer to the mouse
  { "ggandor/leap.nvim", lazy = true, enabled = false },
  -- legendary.nvim
  -- A legend for your keymaps, commands, and autocmds, with which-key.nvim integration
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("devil.configs.plugin.legendary")
    end,
    enabled = false,
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
      require("devil.configs.plugin.lualine")
    end,
  },
  -- neogen
  -- A better annotation generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    config = function()
      require("devil.configs.plugin.neogen")
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
      require("devil.configs.plugin.neoscroll")
    end,
  },
  -- neorg
  -- Modernity meets insane extensibility. The future of organizing your life in Neovim.
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("devil.configs.plugin.neorg")
    end,
  },
  -- neo-tree.nvim
  -- Neovim plugin to manage the file system and other tree like structures
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("devil.configs.plugin.neo-tree")
    end,
  },
  -- node-type.nvim
  -- A Neovim plugin to show the currently selected node type from lsp and treesitter information
  {
    "roobert/node-type.nvim",
    lazy = true,
    config = function()
      require("node-type").setup()
    end,
  },
  -- noice.nvim
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    config = function()
      require("devil.configs.plugin.noice")
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
      require("devil.configs.plugin.nvim-autopairs")
    end,
  },
  -- nvim-bqf
  -- Better quickfix window in Neovim, polish old quickfix window.
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    event = "QuickFixCmdPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("devil.configs.plugin.nvim-bqf")
    end,
  },
  -- nvim-colorizer.lua
  -- The fastest Neovim colorizer
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    config = function()
      require("devil.configs.plugin.nvim-colorizer")
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
      require("devil.configs.plugin.hlslens")
    end,
  },
  -- nvim-jqx
  -- Populate the quickfix with json entries
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    config = function()
      require("devil.configs.plugin.jqx")
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
      require("devil.configs.plugin.nvim-notify")
    end,
  },
  -- nvim-puppeteer
  -- Automatically convert strings to f-strings or template strings and back.
  {
    "chrisgrieser/nvim-puppeteer",
    ft = { "lua", "python", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init = function()
      vim.g.puppeteer_lua_format_string = true
    end,
  },
  -- nvim-qt
  -- Neovim client library and GUI
  { "equalsraf/neovim-gui-shim", lazy = true },
  -- nvim-regexplainer
  -- Describe the regexp under the cursor
  {
    "bennypowers/nvim-regexplainer",
    cmd = { "RegexplainerShow", "RegexplainerToggle" },
    config = function()
      require("devil.configs.plugin.regexplainer")
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
      require("devil.configs.plugin.scrollbar")
    end,
  },
  -- nvim-spectre
  -- Find the enemy and replace them with dark power.
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  -- nvim-surrond
  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    config = function()
      require("devil.configs.plugin.nvim-surround")
    end,
  },
  -- nvim-test
  -- A Neovim wrapper for running tests
  {
    "klen/nvim-test",
    cmd = { "TestSuite", "TestFile", "TestEdit", "TestNearest", "TestLast", "TestVisit", "TestInfo" },
    config = function()
      require("devil.configs.plugin.nvim-test")
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
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      require("devil.configs.plugin.nvim-treesitter")
    end,
  },
  -- nvim-treesitter-context
  -- Show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("devil.configs.plugin.nvim-treesitter-context")
    end,
  },
  -- nvim-ufo
  -- Not UFO in the sky, but an ultra fold in Neovim
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("devil.configs.plugin.nvim-ufo")
    end,
  },
  -- nvim-window-picker
  -- This plugins prompts the user to pick a window and returns the window id of the picked window
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    config = function()
      require("devil.configs.plugin.window-picker")
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
      require("devil.configs.plugin.overseer")
    end,
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction ",
      "OverseerClearCache",
    },
  },
  -- painefer-rust
  -- A Rust port of parinfer.
  {
    "eraserhd/parinfer-rust",
    cmd = "ParinferOn",
    build = "cargo build --release",
  },
  -- persisted.nvim
  -- Simple session management for Neovim, autoloading and Telescope support(forked folke/persistence.nvim)
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("devil.configs.plugin.persisted")
    end,
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
      require("devil.configs.plugin.project")
    end,
  },
  -- rainbow-delimiters.nvim
  -- Rainbow delimiters for Neovim with Tree-sitter
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("devil.configs.plugin.rainbow-delimiters")
    end,
  },
  -- rest.nvim
  -- A fast Neovim http client written in Lua
  {
    "rest-nvim/rest.nvim",
    ft = { "http", "json" },
    config = function()
      require("devil.configs.plugin.rest")
    end,
  },
  -- scope.nvim
  -- Revolutionize Your Neovim Tab Workflow: Introducing Enhanced Tab Scoping!
  {
    "tiagovla/scope.nvim",
    config = function()
      require("devil.configs.plugin.scope")
    end,
  },
  -- smarkcolumn.nvim
  -- A Neovim plugin hiding your colorcolumn when unneeded.
  {
    "m4xshen/smartcolumn.nvim",
    config = function()
      require("devil.configs.plugin.smartcolumn")
    end,
  },
  -- smart-open.nvim
  -- Neovim plugin for fast file-finding
  {
    "danielfalk/smart-open.nvim",
    lazy = true,
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
      -- Only required if using match_algorithm fzf
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  -- sniprun
  -- A neovim plugin to run lines/blocs of code
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    config = function()
      require("devil.configs.plugin.sniprun")
    end,
  },
  -- sqlite.lua
  -- SQLite LuaJIT binding with a very simple api.
  { "kkharji/sqlite.lua", lazy = true, enabled = not jit.os:find("Windows") },
  -- ssr.nvim
  -- Treesitter based structural search and replace plugin for Neovim
  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("devil.configs.plugin.ssr")
    end,
  },
  -- styler.nvim
  -- Simple Neovim plugin to set a different colorscheme per filetype.
  {
    "folke/styler.nvim",
    config = function()
      require("devil.configs.plugin.styler")
    end,
  },
  -- substitute.nvim
  -- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
  {
    "gbprod/substitute.nvim",
    config = function()
      require("devil.configs.plugin.substitute")
    end,
  },
  -- surround-ui.nvim
  -- A Neovim plugin which acts as a helper or training aid for kylechui/nvim-surround
  {
    "roobert/surround-ui.nvim",
    dependencies = {
      "kylechui/nvim-surround",
      "folke/which-key.nvim",
    },
    config = function()
      require("surround-ui").setup({
        root_key = "S",
      })
    end,
  },
  -- tabout.nvim
  -- Supercharge your workflow and start tabbing out from parentheses, quotes, and similar contexts today.
  {
    "abecodes/tabout.nvim",
    config = function()
      require("devil.configs.plugin.tabout")
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "debugloop/telescope-undo.nvim",
    },
    version = "0.1.x",
    config = function()
      require("devil.configs.plugin.telescope")
    end,
  },
  -- text-case.nvim
  -- An all in one plugin for converting text case in Neovim
  { "johmsalas/text-case.nvim", lazy = true },
  -- todo-comments.nvim
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("devil.configs.plugin.todo-comments")
    end,
  },
  -- toggleterm.nvim
  -- A neovim lua plugin to help easily manage multiple terminal windows
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("devil.configs.plugin.toggleterm")
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
      require("devil.configs.plugin.treesj")
    end,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble", "TroubleRefresh", "TroubleClose" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("devil.configs.plugin.trouble")
    end,
  },
  -- twilight.nvim
  -- Dims inactive portions of the code you're editing using TreeSitter.
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require("devil.configs.plugin.twilight")
    end,
  },
  -- ultimate-autopair.nvim
  -- A neovim autopair plugin designed to have all the features that an autopair plugin needs.
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recomended as each new version will have breaking changes
    config = function() end,
  },
  -- urlview.nvim
  -- Neovim plugin for viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("devil.configs.plugin.urlview")
    end,
  },
  -- vim-startuptime
  -- A plugin for profiling Vim and Neovim startup time.
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
      require("devil.configs.plugin.which-key")
    end,
  },
  -- yanky.nvim
  -- Improved Yank and Put functionalities for Neovim
  {
    "gbprod/yanky.nvim",
    config = function()
      require("devil.configs.plugin.yanky")
    end,
  },
  -- zen-mode.nvim
  -- Distraction-free coding for Neovim
  {
    "folke/zen-mode.nvim",
    cmd = "Zen",
    config = function()
      require("devil.configs.plugin.zen-mode")
    end,
  },
}
