local status, treesj = pcall(require, "treesj")
if not status then
  vim.notify("treej not found", "error")
  return
end

local opts = {}

treesj.setup(opts)
