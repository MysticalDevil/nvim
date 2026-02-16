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
  -- sqlite.lua
  -- SQLite LuaJIT binding with a very simple api.
  { "kkharji/sqlite.lua", lazy = true, enabled = vim.uv.os_uname().sysname ~= "Windows_NT" },
  -- mini.icons
  -- Icon provider. Part of 'mini.nvim' library.
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- nvim-qt
  -- Neovim client library and GUI
  { "equalsraf/neovim-gui-shim", lazy = true },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  --
  --------------------------------------- Common plugins ----------------------------------------
  -- beacon.nvim
  -- Neovim plugin to flash cursor when jumps or moves between windows
  {
    "rainbowhxch/beacon.nvim",
    opts = others_configs.beacon,
  },
  -- bufferline.nvim
  -- A snazzy bufferline for Neovim
  {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "VeryLazy",
    keys = utils.get_lazy_keys("bufferline"),
    opts = function()
      return require("devil.plugins.configs.bufferline")
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
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
    keys = utils.get_lazy_keys("flash"),
    opts = require("devil.plugins.configs.flash"), ---@diagnostic disable-line
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
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = require("devil.utils").get_lazy_keys("inc_rename"), -- Use the shared lazy-key helper
    opts = {},
  },
  -- lualine.nvim
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = { "nvim-mini/mini.icons" },
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
        desc = "Use neogen to generate",
      },
    },
    opts = others_configs.neogen,
  },
  -- neo-tree.nvim
  -- Neovim plugin to manage the file system and other tree like structures
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    cmd = { "Neotree" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-mini/mini.icons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<A-m>", "<cmd>Neotree toggle<CR>", desc = "Toggle neo-tree" },
      { "\\", "<cmd>Neotree reveal<CR>", desc = "Reveal neo-tree" },
    },
    opts = function(_, opts)
      local function on_move(data)
        if _G.Snacks and Snacks.rename and Snacks.rename.on_rename_file then
          Snacks.rename.on_rename_file(data.source, data.destination)
          return
        end

        local ok, snacks = pcall(require, "snacks")
        if ok and snacks.rename and snacks.rename.on_rename_file then
          snacks.rename.on_rename_file(data.source, data.destination)
        end
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      return require("devil.plugins.configs.neo-tree")
    end,
  },
  -- noice.nvim
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
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
  },
  -- nvim-hlslens
  -- Hlsearch Lens for Neovim
  {
    "kevinhwang91/nvim-hlslens",
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
    },
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
    opts = require("devil.plugins.configs.regexplainer"),
  },
  -- nvim-scrollbar
  -- Extensible Neovim Scrollbar
  {
    "petertriho/nvim-scrollbar",
    opts = function()
      require("devil.plugins.configs.scrollbar")
      require("scrollbar.handlers.gitsigns").setup()
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
  -- nvim-surround
  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- nvim-treesitter
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
          vim.g.no_plugin_map = true
        end,
      },
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
    opts = require("devil.plugins.configs.treesitter"),
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-dap-repl-highlights").setup()

      -- enable Folding module
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.treesitter.language.register("cpp", "mpp")
      vim.treesitter.language.register("cpp", "ixx")
    end,
  },
  -- nvim-treesitter-context
  -- Show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = require("devil.plugins.configs.treesitter-context"),
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
    keys = utils.get_lazy_keys("ufo"),
    opts = require("devil.plugins.configs.ufo"), ---@diagnostic disable-line
  },
  -- nvim-window-picker
  -- This plugins prompts the user to pick a window and returns the window id of the picked window
  {
    "s1n7ax/nvim-window-picker",
    version = "v2.*",
    opts = require("devil.plugins.configs.window-picker"),
  },
  -- overseer.nvim
  -- A task runner and job management plugin for Neovim
  {
    "stevearc/overseer.nvim",
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
  -- snacks.nvim
  -- A collection of QoL plugins for Neovim
  {
    "folke/snacks.nvim",
    priority = 1000,
    event = "VeryLazy",
    keys = utils.get_lazy_keys("snacks"),
    opts = require("devil.plugins.configs.snacks"),
  },
  -- smartcolumn.nvim
  -- A Neovim plugin hiding your colorcolumn when unneeded.
  {
    "m4xshen/smartcolumn.nvim",
    opts = others_configs.smartcolumn,
  },
  -- smart-open.nvim
  -- Neovim plugin for fast file-finding
  {
    "danielfalk/smart-open.nvim",
    lazy = true,
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
    keys = utils.get_lazy_keys("smart_splits"),
    opts = require("devil.plugins.configs.smart-splits"),
  },
  -- sniprun
  -- A neovim plugin to run lines/blocs of code
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    opts = require("devil.plugins.configs.sniprun"),
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
      "desdic/agrolens.nvim",

      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    version = "^0.2",
    keys = utils.get_lazy_keys("telescope"),
    opts = function()
      return require("devil.plugins.configs.telescope")
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
    opts = others_configs.todo_comments,
  },
  -- ts-comments.nvim
  -- Tiny plugin to enhance Neovim's native comments
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
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
    opts = others_configs.treesj,
  },
  -- trouble.nvim
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all the trouble your code is causing
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-mini/mini.icons",
    keys = utils.get_lazy_keys("trouble"),
    opts = { use_diagnostic_signs = true },
  },
  -- urlview.nvim
  -- Neovim plugin for viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    opts = function()
      return require("devil.plugins.configs.urlview")
    end,
  },
  -- which-key.nvim
  -- Create key bindings that stick
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = utils.get_lazy_keys("whichkey"),
    config = function()
      require("devil.plugins.configs.which-key")
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
    keys = utils.get_lazy_keys("yanky"),
    opts = {},
  },

  --------------------------------------------- Git ---------------------------------------------
  -- diffview.nvim
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
  },
  -- gitsigns.nvim
  -- Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = "BufReadPre",
    keys = utils.get_lazy_keys("gitsigns"),
    opts = require("devil.plugins.configs.gitsigns"), ---@diagnostic disable-line
  },
  -- neogit
  -- magit for neovim
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
  },
}
