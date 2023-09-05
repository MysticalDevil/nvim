local name = "onedark"

local colorscheme = vim.api.nvim_command("colorscheme " .. name)

if colorscheme == nil then
  return
end

vim.api.nvim_command("colorscheme " .. name)
