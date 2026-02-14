local create_cmd = vim.api.nvim_create_user_command
local notify = require("devil.utils.notify")

create_cmd("BufOnly", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      pcall(vim.api.nvim_buf_delete, buf, { force = false })
    end
  end
end, { desc = "Close all other buffers" })

create_cmd("CopyRelPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  notify.info("Copied relative path: " .. path)
end, { desc = "Copy relative file path to clipboard" })

create_cmd("ToggleDiagnostics", function()
  local is_enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not is_enabled)
  notify.info("Diagnostics: " .. (not is_enabled and "Enabled" or "Disabled"))
end, { desc = "Toggle diagnostics globally" })

create_cmd("FixIndent", function()
  vim.cmd("retab")
  vim.cmd("normal! gg=G")
  notify.info("Indentation fixed!")
end, { desc = "Fix indentation for whole file" })
