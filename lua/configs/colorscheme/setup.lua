local colorscheme_name = "onedark"

local status_ok, colorscheme = pcall(require, colorscheme_name)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme_name .. " not found!", "error")
  return
end

colorscheme.load()
