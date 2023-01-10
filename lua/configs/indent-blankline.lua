local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
  vim.notify("indent_blankline not found")
  return
end

local opts = {
  -- 空行占位
  space_char_blankline = " ",
  -- 同 treesitter 判断上下文
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
  -- 竖线样式
  -- char = '¦'
  -- char = '┆'
  -- char = '│'
  -- char = "⎸",
  char = "▏",
}

indent_blankline.setup(opts)
