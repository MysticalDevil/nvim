local status, neogen = pcall(require, "neogen")
if not status then
  vim.notify("neogen not found", "error")
  return
end

local opts = {}

neogen.setup(opts)
