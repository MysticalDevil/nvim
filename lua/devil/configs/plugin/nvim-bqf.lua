local status, bqf = pcall(require, "bqf")
if not status then
  vim.notify("nvim-bqf not found", "error")
end

local opts = {}

bqf.setup(opts)
