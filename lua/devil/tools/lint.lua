local status, lint = pcall(require, "lint")
local notify = require("devil.shared.notify")
if not status then
  notify.error("nvim-lint not found")
  return
end

lint.linters_by_ft = {
  cmake = { "cmakelint" },
  go = { "golangcilint" },
  javascript = { "oxlint" },
  javascriptreact = { "oxlint" },
  json = { "jsonlint" },
  lua = { "selene" },
  markdown = { "rumdl" },
  php = { "mago_lint" },
  ruby = { "rubocop" },
  sh = { "shellcheck" },
  typescript = { "oxlint" },
  typescriptreact = { "oxlint" },
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
