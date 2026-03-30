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
  formatters_by_ft = {
    bash = { "beautysh" },
    c = { "clang-format" },
    cmake = { "gersemi" },
    cpp = { "clang-format" },
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
    markdown = { "rumdl" },
    php = { "mago_format" },
    python = python_fmt,
    ruby = { "rubocop" },
    rust = { "rustfmt" },
    sh = { "beautysh" },
    toml = { "taplo" },
    xml = { "xmlformatter" },
    yaml = yaml_fmt,
    zig = { "zigfmt" },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    local slow_format_filetypes = { "ruby" }
    local buf_ft = vim.bo[bufnr].filetype

    if vim.tbl_contains(slow_format_filetypes, buf_ft) then
      return { timeout_ms = 5000, lsp_format = "fallback" }
    end

    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  notify_no_formatters = true,
  formatters = {},
})
