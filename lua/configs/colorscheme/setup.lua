local name = "onedark"

local status_ok, _ = pcall(vim.api.nvim_command, "colorscheme " .. name)
if not status_ok then
  vim.notify("colorscheme " .. name .. " not found!", "error")
  return
end
