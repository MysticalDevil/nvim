local conform = require("conform")

local function web_fmt(bufnr)
  if conform.get_formatter_info("biome-check", bufnr).available then
    return { "biome-check" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

local function python_fmt(bufnr)
  if conform.get_formatter_info("ruff_format", bufnr).available then
    return { "ruff_format" }
  else
    return { "isort", "black" }
  end
end

local function yaml_fmt(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(bufname, ":t")

  if filename == "docker-compose.yml" then
    return { "yamlfmt" }
  end

  if filename == "pubspec.yaml" then
    return {}
  end

  return { "yamlfmt" }
end

conform.setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    bash = { "beautysh" },
    c = { "clang_format" },
    cmake = { "gersemi" },
    cpp = { "clang_format" },
    cs = { "csharpier" },
    dart = { "dart_format" },
    fish = { "fish_indent" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    javascript = web_fmt,
    typescript = web_fmt,
    javascriptreact = web_fmt,
    typescriptreact = web_fmt,
    json = { "jq" },
    lua = { "stylua" },
    php = { "mago_format" },
    python = python_fmt,
    ruby = { "rubocop" },
    rust = { "rustfmt" },
    sh = { "beautysh" },
    toml = { "taplo" },
    xml = { "xmlformat" },
    yaml = yaml_fmt,
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
  format_on_save = function(bufnr)
    local slow_format_filetypes = { "ruby" }
    local buf_ft = vim.bo[bufnr].filetype

    if vim.tbl_contains(slow_format_filetypes, buf_ft) then
      return { timeout_ms = 5000, lsp_fallback = true }
    end

    return { timeout_ms = 1000, lsp_fallback = true }
  end,
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,
  -- Define custom formatters here
  formatters = {},
})
