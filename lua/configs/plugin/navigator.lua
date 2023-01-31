local status, navigator = pcall(require, "navigator")
if not status then
  vim.notify("navigator.lua not found", "error")
  return
end

navigator.setup()
