local status, lint = pcall(require, "lint")
local notify = require("devil.utils.notify")
if not status then
  notify.error("nvim-lint not found")
  return
end

local settings = require("devil.core.settings")

lint.linters_by_ft = {
  cmake = { "cmakelint" },
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

if settings.lint.auto_run then
  vim.api.nvim_create_autocmd(settings.lint.events, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })
end
