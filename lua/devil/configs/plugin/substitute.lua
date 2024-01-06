local status, substitute = pcall(require, "substitute")
if not status then
  vim.notify("substitute.nvim not found", "error")
  return
end

local opts = {}

substitute.setup(opts)

vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
