local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("formatter not found", "error")
  return
end

formatter.setup({
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            --   '--config-path '
            --       .. os.getenv('XDG_CONFIG_HOME')
            --       .. '/stylua/stylua.toml',
            "-",
          },
          stdin = true,
        }
      end,
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },

    javascript = function()
      return {
        exe = "prettier",
        arge = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
        stdin = true,
      }
    end,
  },
})

-- format on save
vim.api.nvim_exec([[
autogroup FormatAutoGroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
autogroup END
]])
