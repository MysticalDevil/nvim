local utils = require("utils")

vim.opt.guifont = "Fira Code,Noto Color Emoji,FiraCode Nerd Font,Hack Nerd Font:h12"
vim.g.remember_window_size = true
vim.g.remember_window_position = true

vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8

local function toggleFullscreen()
  if vim.g.neovide_fullscreen == false then
    vim.g.neovide_fullscreen = true
  else
    vim.g.neovide_fullscreen = false
  end
end

utils.keymap("n", "<F11>", function()
  toggleFullscreen()
end)
