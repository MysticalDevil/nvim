local status, urlview = pcall(require, "urlview")
if not status then
  vim.notify("urlview.nvim not found")
  return
end

local opts = {}

urlview.setup(opts)

vim.keymap.set("n", "\\u", "<Cmd>UrlView<CR>", { desc = "view buffer URLs" })
vim.keymap.set("n", "\\U", "<Cmd>UrlView packer<CR>", { desc = "view plugin URLs" })
