local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
  vim.notify("lsp_signature.nvim not found", "error")
  return
end

local opts = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  floating_window = true,
  floating_window_above_cur_line = true,
  hint_enable = true,
  fix_pos = false,
  handler_opts = {
    border = "rounded",
  },
}

lsp_signature.setup(opts)
