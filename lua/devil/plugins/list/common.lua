local utils = require("devil.utils")

local others_configs = require("devil.plugins.configs.others")

return {
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  -- plenary.nvim
  -- plenary: full; complete; entire; absolute; unqualified.
  -- All the lua functions I don't want to write twice.
  { "nvim-lua/plenary.nvim", lazy = true },
  -- nui.nvim
  -- UI Component Library for Neovim
  { "MunifTanjim/nui.nvim", lazy = true },
  -- dressing.nvim
  -- Neovim plugin to improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = function()
      return require("devil.plugins.configs.dressing")
    end,
  },
  -- sqlite.lua
  -- SQLite LuaJIT binding with a very simple api.
  { "kkharji/sqlite.lua", lazy = true, enabled = not jit.os:find("Windows") },
  -- nvim-web-devicons
  -- lua `fork` of vim-web-devicons for neovim
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- nvim-qt
  -- Neovim client library and GUI
  { "equalsraf/neovim-gui-shim", lazy = true },

  -- onedark.nvim
  -- One dark and light colorscheme for neovim
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return require("devil.plugins.configs.onedark")
    end,
  },

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
    opts = function()
      return others_configs.beacon
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
    version = "v4.*",
    init = function()
      utils.load_mappings("bufferline")
    end,
    opts = function()
      return require("devil.plugins.configs.bufferline")
    end,
  },
  -- cellular-automaton.nvim
  -- A useless plugin that might help you cope with stubbornly broken tests or overall lack of sense in life.
  -- It lets you execute aesthetically pleasing, cellular automaton animations based on the content of neovim buffer.
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      n = {
        ["<leader>fml"] = { "<cmd> CellularAutomaton make_it_rain <CR>", "Let code be rain" },
      },
    },
  },
  -- Comment.nvim
  -- Smart and powerful comment plugin for neovim
  {
    "numToStr/Comment.nvim",
    opts = function()
      return require("devil.plugins.configs.comment")
    end,
  },
  -- dashboard-nvim
  -- Fancy and Blazing Fast start screen plugin of neovim
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require("devil.plugins.configs.dashboard")
    end,
    config = function(_, opts)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      require("dashboard").setup(opts)
    end,
  },
  -- dial.nvim
  -- enhanced increment/decrement plugin for Neovim.
  {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("devil.plugins.configs.dial")
    end,
  },
  -- flash.nvim
  -- Navigate your code with search labels, enhanced character motions and Treesitter integration
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
    opts = function()
      return require("devil.plugins.configs.flash")
    end,
  },
  -- glow.nvim
  -- A markdown preview directly in your neovim.
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- headlines.nvim
  -- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require("devil.plugins.configs.headlines")
    end,
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
    keys = {
      { "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", desc = "Pick icon in normal mode" },
      { "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", desc = "Pick icon in yank" },
    },
    opts = {
      disable_legacy_commands = true,
    },
  },
  -- illuminate.vim
  -- (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either
  -- LSP, Tree-sitter, or regex matching.
  {
    "RRethy/vim-illuminate",
    opts = function()
      return require("devil.plugins.configs.illuminate")
    end,
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- indent-blankline.nvim
  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "UIEnter",
    opts = function()
      return require("devil.plugins.configs.ibl")
    end,
    config = function(_, opts)
      local hooks = require("ibl.hooks")

      require("ibl").setup(opts)

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      -- hide first line indent
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    end,
  },

  -- legendary.nvim
  -- A legend for your keymaps, commands, and autocmds, with which-key.nvim integration
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua",
      "mrjones2014/smart-splits.nvim",
    },
    opts = function()
      return require("devil.plugins.configs.legendary")
    end,
  },
  -- lualine.nvim
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      return require("devil.plugins.configs.lualine")
    end,
  },
  -- neogen
  -- A better annotation generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      {
        "<leader>nf",
        function()
          require("neogen").generate({ type = "any" })
        end,
        desc = "Use neogeo to generate",
      },
    },
    opts = function()
      return others_configs.neogen
    end,
  },
  -- neoscroll.nvim
  -- Smooth scrolling neovim plugin written in lua
  {
    "karb94/neoscroll.nvim",
    opts = function()
      return others_configs.neoscroll
    end,
  },
  -- neorg
  -- Modernity meets insane extensibility. The future of organizing your life in Neovim.
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return others_configs.neorg
    end,
  },
  -- neo-tree.nvim
  -- Neovim plugin to manage the file system and other tree like structures
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<A-m>", "<cmd>Neotree toggle<CR>", desc = "Toggle neo-tree" },
      { "\\", "<cmd>Neotree reveal<CR>", desc = "Reveal neo-tree" },
    },
    opts = function()
      return require("devil.plugins.configs.neo-tree")
    end,
    config = function(_, opts)
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require("neo-tree").setup(opts)
    end,
  },
  -- node-type.nvim
  -- A Neovim plugin to show the currently selected node type from lsp and treesitter information
  { "roobert/node-type.nvim", lazy = true },
  -- noice.nvim
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      return require("devil.plugins.configs.noice")
    end,
  },
  -- nvim-bqf
  -- Better quickfix window in Neovim, polish old quickfix window.
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    event = "QuickFixCmdPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
    opts = function()
      return require("devil.plugins.configs.colorizer")
    end,
  },
  -- nvim-hlslens
  -- Hlsearch Lens for Neovim
  {
    "kevinhwang91/nvim-hlslens",
    init = function()
      -- utils.load_mappings("hlslens")
    end,
    opts = {
      build_position_cb = function(plist, _, _, _)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
      end,
    },
  },
  -- nvim-neoclip
  -- Clipboard manager neovim plugin with telescope integration
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
      { "nvim-telescope/telescope.nvim" },
    },
  },
  -- nvim-notify
  -- A fancy, configurable, notification manager for NeoVim
  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      local notify = require("notify")
      ---@diagnostic disable-next-line: missing-fields
      notify.setup({
        stages = "slide",
        timeout = 5000,
        render = "default",
      })
      vim.notyfy = notify
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
  -- nvim-regexplainer
  -- Describe the regexp under the cursor
  {
    "bennypowers/nvim-regexplainer",
    cmd = { "RegexplainerShow", "RegexplainerToggle" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      return require("devil.plugins.configs.regexplainer")
    end,
  },
  -- nvim-scrollbar
  -- Extensible Neovim Scrollbar
  {
    "petertriho/nvim-scrollbar",
    opts = function()
      require("devil.plugins.configs.scrollbar")
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
    opts = function()
      return require("devil.plugins.configs.surround")
    end,
  },
  -- nvim-treesitter
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-tree-docs",
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
      "ziontee113/syntax-tree-surfer",
    },
    opts = function()
      return require("devil.plugins.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").prefer_git = true

      -- enable Folding module
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      require("devil.core.extra-parser")
    end,
  },
  -- nvim-treesitter-context
  -- Show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function()
      return require("devil.plugins.configs.treesitter-context")
    end,
  },
  -- nvim-ts-context-commentstring
  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  -- nvim-ufo
  -- Not UFO in the sky, but an ultra fold in Neovim
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    init = function()
      utils.load_mappings("ufo")
    end,
    opts = function()
      return require("devil.plugins.configs.ufo")
    end,
  },
  -- nvim-window-picker
  -- This plugins prompts the user to pick a window and returns the window id of the picked window
  {
    "s1n7ax/nvim-window-picker",
    version = "v2.*",
    opts = function()
      return require("devil.plugins.configs.window-picker")
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
    keys = {
      {
        "<leader>ps",
        function()
          require("persisted").load()
        end,
        desc = "Load session",
      },
      {
        "<leader>pl",
        function()
          require("persisted").load({ last = true })
        end,
        desc = "Load last session",
      },
      {
        "<leader>pd",
        function()
          require("persisted").stop()
        end,
        desc = "Stop session",
      },
    },
    opts = function()
      return require("devil.plugins.configs.persisted")
    end,
  },
  -- rainbow-delimiters.nvim
  -- Rainbow delimiters for Neovim with Tree-sitter
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
          latex = function()
            if vim.fn.line("$") > 10000 then
              return nil
            elseif vim.fn.line("$") > 1000 then
              return rainbow_delimiters.strategy["global"]
            end
            return rainbow_delimiters.strategy["local"]
          end,
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          javascript = "rainbow-delimiters-react",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  -- registers.nvim
  -- Neovim plugin to preview the contents of the registers
  {
    "tversteeg/registers.nvim",
    border = "rounded",
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    adjust_window = true,
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_confirm = "<cr>",
      replace_all = "<leader><cr>",
    },
    name = "registers",
    keys = {
      { '"', mode = { "n", "v" } },
      { "<C-R>", mode = "i" },
    },
    cmd = "Registers",
  },
  -- rest.nvim
  -- A fast Neovim http client written in Lua
  {
    "rest-nvim/rest.nvim",
    ft = { "http", "json" },
    opts = function()
      return require("devil.plugins.configs.rest")
    end,
  },
  -- smarkcolumn.nvim
  -- A Neovim plugin hiding your colorcolumn when unneeded.
  {
    "m4xshen/smartcolumn.nvim",
    opts = function()
      return others_configs.smartcolumn
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
  -- smart-splits.nvim
  -- Smart, seamless, directional navigation and resizing of Neovim +
  -- terminal multiplexer splits. Supports tmux, Wezterm, and Kitty.
  -- Think about splits in terms of "up/down/left/right".
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    version = ">=1.0.0",
    opts = function()
      return require("devil.plugins.configs.smart-splits")
    end,
  },
  -- sniprun
  -- A neovim plugin to run lines/blocs of code
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    opts = function()
      return require("devil.plugins.configs.sniprun")
    end,
  },
  -- ssr.nvim
  -- Treesitter based structural search and replace plugin for Neovim
  {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    keys = {
      {
        "<leader>sr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
      },
    },
    -- Calling setup is optional.
    opts = function()
      return others_configs.ssr
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      return require("devil.plugins.configs.tabout")
    end,
  },
  -- telescope.nvim
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-env.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",

      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    version = "0.1.x",
    init = function()
      utils.load_mappings("telescope")
    end,
    opts = function()
      require("devil.plugins.configs.telescope")
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
    opts = function()
      return others_configs.todo_comments
    end,
  },
  -- toggleterm.nvim
  -- A neovim lua plugin to help easily manage multiple terminal windows
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    opts = function()
      return require("devil.plugins.configs.toggleterm")
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
    opts = function()
      return others_configs.treesj
    end,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble", "TroubleRefresh", "TroubleClose" },
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      utils.load_mappings("trouble")
    end,
    opts = function()
      return require("devil.plugins.configs.trouble")
    end,
  },
  -- twilight.nvim
  -- Dims inactive portions of the code you're editing using TreeSitter.
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
  -- ultimate-autopair.nvim
  -- A neovim autopair plugin designed to have all the features that an autopair plugin needs.
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = function()
      return require("devil.plugins.configs.ultimate-autopair")
    end,
  },
  -- urlview.nvim
  -- Neovim plugin for viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = function()
      return require("devil.plugins.configs.urlview")
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
    cmd = "WhichKey",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      utils.load_mappings("whichkey")
    end,
    opts = function()
      return require("devil.plugins.configs.which-key")
    end,
  },
  -- workspaces.nvim
  -- a simple plugin to manage workspace directories in neovim
  {
    "natecraddock/workspaces.nvim",
    cmd = {
      "WorkspacesAdd",
      "WorkspacesAddDir",
      "WorkspacesRemove",
      "WorkspacesRemoveDir",
      "WorkspacesRename",
      "WorkspacesList",
      "WorkspacesListDirs",
      "WorkspacesOpen",
      "WorkspacesSyncDirs",
    },
    opts = {
      hooks = {
        open = { "Telescope find_files" },
      },
    },
  },
  -- yanky.nvim
  -- Improved Yank and Put functionalities for Neovim
  {
    "gbprod/yanky.nvim",
    init = function()
      utils.load_mappings("yanky")
    end,
    opts = function()
      return require("devil.plugins.configs.yanky")
    end,
  },
  -- zen-mode.nvim
  -- Distraction-free coding for Neovim
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Enter zen mode" },
    },
    cmd = "Zen",
    opts = function()
      return require("devil.plugins.configs.zen-mode")
    end,
  },
}
