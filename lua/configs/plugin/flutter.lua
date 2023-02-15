local status, flutter_tools = pcall(require, "flutter-tools")
if not status then
  vim.notify("flutter-tools.nvim not found", "error")
  return
end

local opts = {}

flutter_tools.setup(opts)
