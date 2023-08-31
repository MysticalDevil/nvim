local status, notify = pcall(require, "notify")
if not status then
  vim.notify("nvim-notify not found", "error")
  return
end

local opts = {
  stages = "slide",
  timeout = 5000,
  render = "default",
}

notify.setup(opts)

vim.notify = notify
