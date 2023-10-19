lua << EOF

if vim.g.neovide then
  require("devil.configs.gui.neovide")
end

if vim.g.GuiLoaded then
  require("devil.configs.gui.nvim-qt")
end

if vim.g.fvim_loaded then
  require("devil.configs.gui.fvim")
end

EOF
