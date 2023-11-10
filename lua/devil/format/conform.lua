local status, conform = pcall(require, "conform")
if not status then
  vim.notify("conform.nvim not found", "error")
  return
end

local opts = {
  -- Map of filetype to formatters
  formatters_by_ft = {
    bash = { "beautysh" },
    c = { "clang_format" },
    clojure = { "zprint" },
    cmake = { "cmake_format" },
    cpp = { "clang_format" },
    cs = { "charpier" },
    dart = { "dart_format" },
    elixir = { "mix" },
    fish = { "fish_indent" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    java = { "google-java-format" },
    javascript = { { "prettierd", "prettier" } },
    json = { "jq" },
    kotlin = { "ktlint" },
    lua = { "stylua" },
    perl = { "perlimports", "perltidy" },
    python = { "isort", "black" },
    ruby = { "standardrb" },
    rust = { "rustfmt" },
    scala = { "scalafmt" },
    sh = { "beautysh" },
    toml = { "taplo" },
    xml = { "xmlformat" },
    yaml = { "yamlfmt" },
    zig = { "zigfmt" },
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_fallback = true,
    timeout_ms = 500,
  },
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_fallback = true,
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Define custom formatters here
  formatters = {
    prettier = {
      command = require("conform.util").find_executable({ "node_modules/.bin/prettier" }, "prettier"),
      args = { "--no-semi" },
      stdin = true,
      cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
      require_cwd = true,
    },
  },
}

conform.setup(opts)
