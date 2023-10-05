local status, lspkind = pcall(require, "lspkind")
if not status then
  vim.notify("lspkind.nvim not found", "error")
  return
end

lspkind.init({
  -- default: true
  -- with_text = true,
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  preset = "default",
  -- override preset symbols
  --
  -- default: {}
  symbol_map = require("utils").kind_icons,
})
