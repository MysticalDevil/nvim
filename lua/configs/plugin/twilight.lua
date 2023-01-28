local status, twilight = pcall(require, "twilight")
if not status then
  vim.notify("twilight.nvim not found")
  return
end

local opts = {}

twilight.setup(opts)
