local status, colorizer = pcall(require, "colorizer")
if not status then
  vim.notify("nvim-colorizer not found")
  return
end

local opts = {}

colorizer.setup(opts)
