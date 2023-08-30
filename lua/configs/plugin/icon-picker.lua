local status, icon_picker = pcall(require, "icon-picker")
if not status then
  vim.notify("icon-picker not found", "error")
  return
end

local utils = require("utils.setup")

local opts = {
  disable_legacy_commands = true,
}

icon_picker.setup(opts)

utils.keymap("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>")
utils.keymap("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>") --> Yank the selected icon into register
