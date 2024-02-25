local status, lint = pcall(require, "lint")
if not status then
  vim.notify("nvim-lint not found", "error")
  return
end

lint.linters_by_ft = {
  c = { "clangtidy" },
  clojure = { "clj-knodo" },
  cmake = { "cmake-lint" },
  css = { "stylelint" },
  cpp = { "clangtidy" },
  go = { "golangcilint" },
  java = { "checkstyle" },
  json = { "jsonlint" },
  kotlin = { "ktlint" },
  lua = { "selene" },
  markdown = { "markdownlint" },
  python = { "ruff" },
  ruby = { "standardrb" },
  sh = { "shellcheck" },
  vim = { "vint" },
  yaml = { "yamllint" },
}
