local font_name = "FiraCode Nerd Font"
local font_size = 12

local function toggleFullscreen()
  if vim.g.GuiWindowFullScreen == 0 then
    vim.cmd("call GuiWindowFullScreen(" .. 1 .. ")")
  else
    vim.cmd("call GuiWindowFullScreen(" .. 0 .. ")")
  end
end

vim.keymap.set("n", "<F11>", toggleFullscreen, { silent = true })

vim.cmd([[
GuiTabline 0
GuiPopupmenu 0
GuiRenderLigatures 1
]])
vim.cmd("GuiFont! " .. font_name .. ":h" .. font_size)
