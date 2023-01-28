local status, illuminate = pcall(require, "illuminate")
if not status then
  vim.notify("vim-illuminate not found", "error")
  return
end

local opts = {}

illuminate.configure()
