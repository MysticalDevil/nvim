local status, notify = pcall(require, "notify")
if not status then
  vim.notify("nvim-notify not found", "error")
  return
end

local opts = {}

notify.setup(opts)

vim.notify = notify
