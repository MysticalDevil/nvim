local status, lint = pcall(require, "lint")
if not status then
  vim.notify("nvim-lint not found", "error")
  return
end

lint.linters_by_ft = {
  lua = {
    "luacheck",
  },
}
