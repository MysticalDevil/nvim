local status, styler = pcall(require, "styler")
if not status then
  vim.notify("styler.nvim not found", "error")
  return
end

local opts = {
  themes = {
    markdown = { colorscheme = "tokyonight" },
    help = { colorscheme = "catppuccin-mocha", background = "dark" },
  },
}

styler.setup(opts)