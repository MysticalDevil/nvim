local status, lsp_lines = pcall(require, "lsp_lines")
if not status then
  vim.notify("lsp_lines.nvim not found", "error")
  return
end

vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

lsp_lines.setup()
