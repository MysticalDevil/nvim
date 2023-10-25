local status, substitute = pcall(require, "substitute")
if not status then
  vim.notify("substitute.nvim not found", "error")
  return
end

local opts = {
  on_substitute = nil,
  yank_substituted_text = false,
  preserve_cursor_position = false,
  highlight_substituted_text = {
    enabled = true,
    timer = 500,
  },
  range = {
    prefix = "s",
    prompt_current_text = false,
    confirm = false,
    complete_word = false,
    motion1 = false,
    motion2 = false,
    suffix = "",
  },
  exchange = {
    motion = false,
    use_esc_to_cancel = true,
    preserve_cursor_position = false,
  },
}

substitute.setup(opts)

vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
