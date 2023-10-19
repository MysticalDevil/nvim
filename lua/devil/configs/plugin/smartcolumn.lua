local status, smartcolumn = pcall(require, "smartcolumn")
if not status then
  vim.notify("smartcolumn.nvim not found", "error")
  return
end

smartcolumn.setup({
  colorcolumn = "130",
  disabled_filetypes = {
    "help",
    "text",
    "markdown",
    "alpha",
    "aerial",
    "neo-tree",
    "nerdtree",
    "NvimTree",
    "dashboard",
    "Trouble",
    "DiffViewFiles",
    "dapui_stacks",
    "dapui_scopes",
    "dapui_watches",
    "dapui_breakpoints",
    "dapui_console",
    "dap-repl",
  },
  custom_colorcolumn = {},
  scope = "file",
})
