local status, twilight = pcall(require, "twilight")
if not status then
  vim.notify("twilight.nvim not found", "error")
  return
end

local opts = {}

twilight.setup(opts)
