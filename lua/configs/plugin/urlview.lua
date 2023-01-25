local status, urlview = pcall(require, "urlview")
if not status then
  vim.notify("urlview.nvim not found")
  return
end

local opts = {}

urlview.setup(opts)
