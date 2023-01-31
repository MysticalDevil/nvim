if vim.g.neovide then
  vim.opt.guifont = "Fira Code,Noto Color Emoji,FiraCode Nerd Font:h10"
  vim.g.remember_window_size = true
  vim.g.remember_window_position = true

  vim.cmd("let g:neovide_cursor_animation_length=0.13")
  vim.cmd("let g:neovide_cursor_trail_size=0.8")

  local function toggleFullscreen()
    if vim.g.neovide_fullscreen == false then
      vim.cmd("let g:neovide_fullscreen=v:true")
    else
      vim.cmd("let g:neovide_fullscreen=v:false")
    end
  end

  keymap("n", "<F11>", toggleFullscreen())
end
