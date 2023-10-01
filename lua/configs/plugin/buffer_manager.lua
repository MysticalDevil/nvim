local status, buffer_manager = pcall(require, "buffer_manager")
if not status then
  vim.notify("buffer_manager.nvim not found", "error")
  return
end

local utils = require("utils")

local opts = {
  line_keys = "1234567890",
  select_menu_item_commands = {
    edit = {
      key = "<CR>",
      command = "edit",
    },
  },
  focus_alternate_buffer = false,
  short_file_names = false,
  short_term_names = false,
  loop_nav = true,
  highlight = "",
  win_extra_options = {},
  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

buffer_manager.setup(opts)

local bmui = require("buffer_manager.ui")
local keys = "1234567890"
for i = 1, #keys do
  local key = keys:sub(i, i)
  utils.keymap("n", string.format("<leader>%s", key), function()
    bmui.nav_file(i)
  end)
end
-- Just the menu
utils.keymap({ "t", "n" }, "<M-Space>", bmui.toggle_quick_menu)
-- Open menu and search
utils.keymap({ "t", "n" }, "<M-m>", function()
  bmui.toggle_quick_menu()
  -- wait for the menu to open
  vim.defer_fn(function()
    vim.fn.feedkeys("/")
  end, 50)
end)
-- Next/Prev
utils.keymap("n", "<M-j>", bmui.nav_next)
utils.keymap("n", "<M-k>", bmui.nav_prev)
