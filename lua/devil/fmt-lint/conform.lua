local conform = require("conform")

local function js_ts_fmt(bufnr)
  if conform.get_formatter_info("biome", bufnr).available then
    return { "biome-check" }
  elseif conform.get_formatter_info("eslint_d", bufnr).available then
    return { "eslint_d" }
  end
end

local opts = {
  -- Map of filetype to formatters
  formatters_by_ft = {
    bash = { "beautysh" },
    c = { "clang_format" },
    cmake = { "cmake_format" },
    cpp = { "clang_format" },
    dart = { "dart_format" },
    fish = { "fish_indent" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    javascript = js_ts_fmt,
    json = { "jq" },
    lua = { "stylua" },
    php = { "mago_format", "mago_lint" },
    python = function(bufnr)
      if conform.get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    ruby = { "standardrb" },
    rust = { "rustfmt" },
    sh = { "beautysh" },
    toml = { "taplo" },
    typescript = js_ts_fmt,
    xml = { "xmlformat" },
    yaml = { "yamlfmt" },
    zig = { "zigfmt" },
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = "fallback",
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
    lsp_format = "fallback",
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,
  -- Define custom formatters here
  formatters = {},
}

conform.setup(opts)
