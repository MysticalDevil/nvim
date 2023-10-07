local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("indent-blankline.nvim not found", "error")
  return
end

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- hide first line indent
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

-- ibl config
local opts = {
  debounce = 100,
  viewport_buffer = {
    min = 30,
    max = 500,
  },
  indent = {
    char = "▏", -- "│",  "│", "¦", "┆", "┊"
    tab_char = { "I", "I", "I" },
    highlight = "IblIndent",
    smart_indent_cap = true,
    priority = 1,
  },
  whitespace = {
    highlight = "IblWhitespace",
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    char = nil,
    show_start = true,
    show_end = false,
    injected_languages = false,
    highlight = highlight,
    priority = 1024,
    include = {
      node_type = {
        lua = {
          "chunk",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
          "function_declaration",
          "function_definition",
          "table_constructor",
          "assignment_statement",
        },
        typescript = {
          "statement_block",
          "function",
          "arrow_function",
          "function_declaration",
          "method_definition",
          "for_statement",
          "for_in_statement",
          "catch_clause",
          "object_pattern",
          "arguments",
          "switch_case",
          "switch_statement",
          "switch_default",
          "object",
          "object_type",
          "ternary_expression",
        },
      },
    },
    exclude = {
      language = {},
      node_type = {
        ["*"] = {
          "source_file",
          "program",
        },
        lua = {
          "chunk",
        },
        python = {
          "module",
        },
      },
    },
  },
  exclude = {
    filetypes = {
      "null-ls-info",
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "mason",
      "mason-lspconfig",
      "lspinfo",
      "toggleterm",
      "text",
      "checkhealth",
      "man",
      "gitcommit",
      "TelescopePrompt",
      "TelescopeResults",
    },
    buftypes = {
      "terminal",
      "nofile",
      "quickfix",
      "prompt",
    },
  },
}

ibl.setup(opts)
