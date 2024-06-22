return {
  -- Letter icon. A is add，M is modify， D is delete
  signs = {
    add = { text = "A|" },
    change = { text = "M|" },
    delete = { text = "D_" },
    topdelete = { text = "D‾" },
    changedelete = { text = "D~" },
    untracked = { text = "U|" },
  },
  -- show icon
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  -- line number highlight
  numhl = false, -- Toggle with `Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `LGitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_with
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}
