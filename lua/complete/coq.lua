local status, coq = pcall(require, "coq")
if not status then
  vim.notify("coq_nvim not found", "error")
  return
end
