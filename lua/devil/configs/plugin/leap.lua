local status, _ = pcall(require, "leap")
if not status then
  vim.notify("leap.nvim not found", "error")
  return
end

---- leap ----
vim.keymap.set("n", "-", "<Plug>(leap-forward)", {})
vim.keymap.set("n", "_", "<Plug>(leap-backward)", {})
