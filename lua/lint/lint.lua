local status, lint = pcall(require, "lint")
if not status then
  vim.notify("nvim-lint not found", "error")
  return
end

lint.linters_by_ft = {
  lua = { "luacheck" },
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  python = { "ruff" },
  ruby = { "standardrb" },
  sh = { "shellcheck" },
  zsh = { "shellcheck" },
  go = { "golangcilint" },
  java = { "checkstyle" },
}
