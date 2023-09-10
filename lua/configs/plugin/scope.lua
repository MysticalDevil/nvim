local status, scope = pcall(require, "scope")
if not status then
  vim.notify("scope.nvim not found", "error")
  return
end

local opts = {}

scope.setup(opts)
