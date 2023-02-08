lua << EOF

if vim.g.neovide then
  require("configs.gui.neovide")
end

if vim.g.GuiLoaded then
  require("configs.gui.nvim-qt")
end

EOF
