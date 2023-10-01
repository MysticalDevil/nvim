local status, action_hints = pcall(require, "action-hints")
if not status then
  vim.notify("action-hints.nvim not found", "error")
  return
end

local opts = {
  template = {
    definition = { text = " ⊛", color = "#add8e6" },
    references = { text = " ↱%s", color = "#ff6666" },
  },
  use_virtual_text = true,
}

action_hints.setup(opts)
