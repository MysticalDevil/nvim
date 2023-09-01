local status, styler = pcall(require, "styler")
if not status then
  vim.notify("styler not found", "error")
  return
end

local opts = {
  themes = {
    markdown = { colorscheme = "gruvbox" },
    help = { colorscheme = "catppuccin-mocha", background = "dark" },
  },
}

styler.setup(opts)
