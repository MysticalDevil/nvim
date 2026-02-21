local utils = require("devil.utils")
local others_configs = require("devil.plugins.configs.others")

return {
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
  -- render-markdown.nvim
  -- Render markdown inside Neovim buffers.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {},
  },
  -- headlines.nvim
  -- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require("devil.plugins.configs.headlines")
    end,
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
        local snacks = package.loaded["snacks"]
        if snacks and snacks.rename and snacks.rename.on_rename_file then
          snacks.rename.on_rename_file(data.source, data.destination)
          return
        end

        local ok, loaded_snacks = pcall(require, "snacks")
        if ok and loaded_snacks.rename and loaded_snacks.rename.on_rename_file then
          loaded_snacks.rename.on_rename_file(data.source, data.destination)
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
}
