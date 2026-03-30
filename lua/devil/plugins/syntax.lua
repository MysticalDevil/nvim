local ufo_keys = {
  {
    "zR",
    function()
      require("ufo").openAllFolds()
    end,
    desc = "Open all folds",
  },
  {
    "zM",
    function()
      require("ufo").closeAllFolds()
    end,
    desc = "Close all folds",
  },
  {
    "zr",
    function()
      require("ufo").openFoldsExceptKinds()
    end,
    desc = "Open all folds except kinds",
  },
  {
    "zm",
    function()
      require("ufo").closeFoldsWith()
    end,
    desc = "Close fold with",
  },
  {
    "zK",
    function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end,
    desc = "Peek folded lines under cursor",
  },
}

return {
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
          select = { lookahead = true },
          move = { set_jumps = true },
        },
        config = function(_, opts)
          require("nvim-treesitter-textobjects").setup(opts)
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        opts = { opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true } },
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
          if vim.api.nvim_buf_line_count(args.buf) <= opts.max_highlight_lines then
            pcall(vim.treesitter.start, args.buf)
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.language.register("cpp", "mpp")
      vim.treesitter.language.register("cpp", "ixx")
    end,
  },
  {
    "MysticalDevil/ts-inject.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = { enable = { bash = true, go = true, python = true, rust = true, zig = true } },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      min_window_height = 0,
      zindex = 20,
      mode = "cursor",
      separator = nil,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    keys = ufo_keys,
    opts = function()
      local function handler(virt_text, lnum, end_lnum, width, truncate)
        local new_virt_text = {}
        local suffix = (" 󰁂 %d "):format(end_lnum - lnum)
        local suffix_width = vim.fn.strdisplaywidth(suffix)
        local target_width = width - suffix_width
        local current_width = 0

        for _, chunk in ipairs(virt_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)
          if target_width > current_width + chunk_width then
            table.insert(new_virt_text, chunk)
          else
            chunk_text = truncate(chunk_text, target_width - current_width)
            table.insert(new_virt_text, { chunk_text, chunk[2] })
            chunk_width = vim.fn.strdisplaywidth(chunk_text)
            if current_width + chunk_width < target_width then
              suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
            end
            break
          end
          current_width = current_width + chunk_width
        end

        table.insert(new_virt_text, { suffix, "MoreMsg" })
        return new_virt_text
      end

      return {
        open_fold_hl_timeout = 400,
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        close_fold_kinds = {},
        enable_get_fold_virt_text = false,
        preview = {
          win_config = {
            border = "rounded",
            winblend = 12,
            winhighlight = "Normal:Normal",
            maxheight = 20,
          },
        },
        fold_virt_text_handler = handler,
      }
    end,
  },
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
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
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
