local status, urlview = pcall(require, "urlview")
if not status then
  vim.notify("urlview.nvim not found", "error")
  return
end

local opts = {}

urlview.setup(opts)
