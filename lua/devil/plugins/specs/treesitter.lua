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
        opts = {
          select = {
            lookahead = true,
          },
          move = {
            set_jumps = true,
          },
        },
        config = function(_, opts)
          require("nvim-treesitter-textobjects").setup(opts)

          local select = require("nvim-treesitter-textobjects.select")
          local move = require("nvim-treesitter-textobjects.move")
          local swap = require("nvim-treesitter-textobjects.swap")
          local keymap = vim.keymap.set

          local function map(modes, lhs, rhs, desc)
            keymap(modes, lhs, rhs, { desc = desc, silent = true })
          end

          map({ "x", "o" }, "af", function()
            select.select_textobject("@function.outer", "textobjects")
          end, "Select function outer")
          map({ "x", "o" }, "if", function()
            select.select_textobject("@function.inner", "textobjects")
          end, "Select function inner")
          map({ "x", "o" }, "ac", function()
            select.select_textobject("@class.outer", "textobjects")
          end, "Select class outer")
          map({ "x", "o" }, "ic", function()
            select.select_textobject("@class.inner", "textobjects")
          end, "Select class inner")
          map({ "x", "o" }, "ai", function()
            select.select_textobject("@conditional.outer", "textobjects")
          end, "Select conditional outer")
          map({ "x", "o" }, "ii", function()
            select.select_textobject("@conditional.inner", "textobjects")
          end, "Select conditional inner")
          map({ "x", "o" }, "al", function()
            select.select_textobject("@loop.outer", "textobjects")
          end, "Select loop outer")
          map({ "x", "o" }, "il", function()
            select.select_textobject("@loop.inner", "textobjects")
          end, "Select loop inner")
          map({ "x", "o" }, "ab", function()
            select.select_textobject("@block.outer", "textobjects")
          end, "Select block outer")
          map({ "x", "o" }, "ib", function()
            select.select_textobject("@block.inner", "textobjects")
          end, "Select block inner")

          map("n", "<leader>a", function()
            swap.swap_next("@parameter.inner", "textobjects")
          end, "Swap next parameter")
          map("n", "<leader>A", function()
            swap.swap_previous("@parameter.inner", "textobjects")
          end, "Swap previous parameter")

          map({ "n", "x", "o" }, "]m", function()
            move.goto_next_start("@function.outer", "textobjects")
          end, "Next function start")
          map({ "n", "x", "o" }, "]]", function()
            move.goto_next_start("@class.outer", "textobjects")
          end, "Next class start")
          map({ "n", "x", "o" }, "]M", function()
            move.goto_next_end("@function.outer", "textobjects")
          end, "Next function end")
          map({ "n", "x", "o" }, "][", function()
            move.goto_next_end("@class.outer", "textobjects")
          end, "Next class end")
          map({ "n", "x", "o" }, "[m", function()
            move.goto_previous_start("@function.outer", "textobjects")
          end, "Previous function start")
          map({ "n", "x", "o" }, "[[", function()
            move.goto_previous_start("@class.outer", "textobjects")
          end, "Previous class start")
          map({ "n", "x", "o" }, "[M", function()
            move.goto_previous_end("@function.outer", "textobjects")
          end, "Previous function end")
          map({ "n", "x", "o" }, "[]", function()
            move.goto_previous_end("@class.outer", "textobjects")
          end, "Previous class end")
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        opts = {
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
          },
        },
      },
      "RRethy/nvim-treesitter-endwise",
    },
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "dart",
        "go",
        "haskell",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "python",
        "ruby",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "zig",
      },
      max_highlight_lines = 10000,
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")

      ts.setup()
      require("nvim-treesitter.install").prefer_git = true

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("devil_treesitter_start", { clear = true }),
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype

          if vim.api.nvim_buf_line_count(args.buf) <= opts.max_highlight_lines then
            pcall(vim.treesitter.start, args.buf)
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- enable Folding module
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.language.register("cpp", "mpp")
      vim.treesitter.language.register("cpp", "ixx")
    end,
  },
  -- ts-inject.nvim
  -- Better TypeScript language injections for modern frontend files.
  {
    "MysticalDevil/ts-inject.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {
      enable = {
        bash = true,
        go = true,
        python = true,
        rust = true,
        zig = true,
      },
    },
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
