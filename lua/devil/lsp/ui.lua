-- Customize icon
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  underline = {
    serverity = { max = vim.diagnostic.severity.WARN },
  },
  signs = true,
  update_in_insert = false,
  show_header = false,
  severity_sort = false,
  float = {
    source = "if_many",
    border = "rounded",
    style = "minimal",
    header = "",
    -- prefix = " ",
    -- max_width = 100,
    -- width = 60,
    -- height = 20,
  },
})

local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = ("DiagnosticSign%s"):format(type)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
