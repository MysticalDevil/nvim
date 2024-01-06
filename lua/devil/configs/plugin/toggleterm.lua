local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("toggleterm not found", "error")
  return
end

local opts = {}

toggleterm.setup(opts)
