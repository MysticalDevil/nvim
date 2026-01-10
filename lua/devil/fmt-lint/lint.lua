local status, lint = pcall(require, "lint")
if not status then
  vim.notify("nvim-lint not found", vim.log.levels.ERROR)
  return
end

lint.linters_by_ft = {
  cmake = { "cmakelint" },
  css = { "stylelint" },
  go = { "golangcilint" },
  json = { "jsonlint" },
  lua = { "selene" },
  markdown = { "markdownlint" },
  php = { "mago_lint" },
  ruby = { "rubocop" },
  sh = { "shellcheck" },
  vim = { "vint" },
  yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
