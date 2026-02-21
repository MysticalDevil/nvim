local utils = require("devil.utils")

return {
  -- nvim-treesitter
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
          vim.g.no_plugin_maps = true
        end,
      },
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
    opts = require("devil.plugins.configs.treesitter"),
    config = function(_, opts)
      local ok_ts, ts = pcall(require, "nvim-treesitter")
      if ok_ts and type(ts.setup) == "function" then
        ts.setup(opts)
      else
        local ok_configs, configs = pcall(require, "nvim-treesitter.configs")
        if ok_configs and type(configs.setup) == "function" then
          configs.setup(opts)
        else
          vim.notify("nvim-treesitter setup module not found", vim.log.levels.WARN)
          return
        end
      end
      require("nvim-treesitter.install").prefer_git = true

      require("nvim-dap-repl-highlights").setup()

      -- enable Folding module
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.language.register("cpp", "mpp")
      vim.treesitter.language.register("cpp", "ixx")
    end,
  },
  -- nvim-treesitter-context
  -- Show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
          "interface",
          "struct",
          "enum",
        },
        tex = {
          "chapter",
          "section",
          "subsection",
          "subsubsection",
        },
        haskell = {
          "adt",
        },
        rust = {
          "impl_item",
        },
        terraform = {
          "block",
          "object_elem",
          "attribute",
        },
        scala = {
          "object_definition",
        },
        vhdl = {
          "process_statement",
          "architecture_body",
          "entity_declaration",
        },
        markdown = {
          "section",
        },
        elixir = {
          "anonymous_function",
          "arguments",
          "block",
          "do_block",
          "list",
          "map",
          "tuple",
          "quoted_content",
        },
        json = {
          "pair",
        },
        typescript = {
          "export_statement",
        },
        yaml = {
          "block_mapping_pair",
        },
      },
      exact_patterns = {},
      zindex = 20,
      mode = "cursor",
      separator = nil,
    },
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
}
