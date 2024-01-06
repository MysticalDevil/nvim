local status, smartcolumn = pcall(require, "smartcolumn")
if not status then
  vim.notify("smartcolumn.nvim not found", "error")
  return
end

smartcolumn.setup()
