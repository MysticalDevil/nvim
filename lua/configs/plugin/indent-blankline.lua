local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("indent-blankline.nvim not found", "error")
  return
end

local opts = {
  debounce = 100,
  viewport_buffer = {
    min = 30,
    max = 500,
  },
  indent = {
    char = "▏",
    tab_char = { "a", "b", "c" },
    highlight = "IblIndent",
    smart_indent_cap = true,
    priority = 2,
  },
  whitespace = {
    highlight = "IblWhitespace",
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    char = nil,
    show_start = true,
    show_end = true,
    injected_languages = false,
    highlight = "IblScope",
    priority = 1024,
    include = { node_type = {} },
    exclude = {
      languages = {},
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
