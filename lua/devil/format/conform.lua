local status, conform = pcall(require, "conform")
if not status then
  vim.notify("conform.nvim not found", "error")
  return
end

local opts = {
  -- Map of filetype to formatters
  formatters_by_ft = {
    bash = { "beautysh" },
    go = { "gofumpt", "goimports", "golines" },
    lua = { "stylua" },
    javascript = { { "prettierd", "prettier" } },
    json = { "jq" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    scala = { "scalafmt" },
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
    my_formatter = {
      -- This can be a string or a function that returns a string
      command = "my_cmd",
      -- OPTIONAL - all fields below this are optional
      -- A list of strings, or a function that returns a list of strings
      -- Return a single string instead to run the command in a shell
      args = { "--stdin-from-filename", "$FILENAME" },
      -- If the formatter supports range formatting, create the range arguments here
      range_args = function(ctx)
        return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
      end,
      -- Send file contents to stdin, read new contents from stdout (default true)
      -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
      -- file is assumed to be modified in-place by the format command.
      stdin = true,
      -- A function that calculates the directory to run the command in
      cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
      -- When cwd is not found, don't run the formatter (default false)
      require_cwd = true,
      -- When returns false, the formatter will not be used
      condition = function(ctx)
        return vim.fs.basename(ctx.filename) ~= "README.md"
      end,
      -- Exit codes that indicate success (default {0})
      exit_codes = { 0, 1 },
      -- Environment variables. This can also be a function that returns a table.
      env = {
        VAR = "value",
      },
    },
    -- These can also be a function that returns the formatter
    other_formatter = function()
      return {
        command = "my_cmd",
      }
    end,
  },
}

conform.setup(opts)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
