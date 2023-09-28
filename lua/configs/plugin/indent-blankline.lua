local status, ibl = pcall(require, "ibl")
if not status then
  vim.notify("indent-blankline.nvim not found", "error")
  return
end

local opts = {
  debounce = 100,
  indent = {
    char = "▏",
    tab_char = { "a", "b", "c" },
    highlight = { "Function", "Label" },
    smart_indent_cap = true,
    priority = 2,
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = true,
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
      "ispinfo",
      "toggleterm",
      "text",
    },
    buftypes = {
      "terminal",
      "dashboard",
    },
  },
}

ibl.setup(opts)
