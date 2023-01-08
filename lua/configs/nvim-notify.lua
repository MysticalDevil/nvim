local status, notify = pcall(require, 'notify')
if not status then
  vim.notify('nvim-notify not found')
  return
end

local opts = {
  stages = 'static',
  timeout = 5000,
}

notify.setup(opts)
vim.notify = notify
