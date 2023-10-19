local status, window_picker = pcall(require, "window-picker")
if not status then
  vim.notify("nvim-window-picker not found", "error")
  return
end

local opts = {
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { "neo-tree", "neo-tree-popup", "notify" },

      -- if the buffer type is one of following, the window will be ignored
      buftype = { "terminal", "quickfix" },
    },
  },
  other_win_hl_color = "#e35e4f",
}

window_picker.setup(opts)
