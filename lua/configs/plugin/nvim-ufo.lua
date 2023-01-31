local status, ufo = pcall(require, "ufo")
if not status then
  vim.notify("nvim-ufo not found", "error")
  return
end
