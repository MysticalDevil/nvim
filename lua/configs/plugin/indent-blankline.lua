local status, indent_blankline = pcall(require, "ibl")
if not status then
  vim.notify("indent-blankline.nvim not found", "error")
  return
end

local opts = {
  show_end_of_line = true,
  space_char_blankline = " ",
  -- judge context
  show_current_context = true,
  show_current_context_start = true,
  context_patterns = {
    "class",
    "function",
    "method",
    "element",
    "^if",
    "^while",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
  },
  -- echo &filetype
  filetype_exclude = {
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
  -- char = '¦'
  -- char = '┆'
  -- char = '│'
  -- char = "⎸",
  char = "▏",
}

indent_blankline.setup(opts)
