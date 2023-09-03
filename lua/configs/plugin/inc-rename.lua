local status, inc_rename = pcall(require, "inc_rename")
if not status then
  vim.notify("inc-rename.nvim not found", "error")
  return
end

local opts = {
  cmd_name = "IncRename", -- the name of the command
  -- the highlight group used for highlighting the identifier's new name
  hl_group = "Substitute",
  -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
  preview_empty_name = false,
  show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
  -- the type of the external input buffer to use (the only supported value is currently "dressing")
  input_buffer_type = nil,
  post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
}

inc_rename.setup(opts)

vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
