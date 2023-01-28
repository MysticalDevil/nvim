local status, icon_picker = pcall(require, "icon-picker")
if not status then
  vim.notify("icon-picker not found", "error")
  return
end

local opts = {
  disable_legacy_commands = true,
}

icon_picker.setup(opts)

keymap("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>")
keymap("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>") --> Yank the selected icon into register
-- keymap("i", "<C-i>", "<cmd>IconPickerInsert<cr>")
