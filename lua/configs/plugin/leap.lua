local status, leap = pcall(require, "leap")
if not status then
  vim.notify("leap.nvim not found", "error")
  return
end

leap.add_default_mappings()
