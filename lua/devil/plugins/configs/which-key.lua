local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify("which-key.nvim not found", vim.log.levels.ERROR)
  return
end

which_key.setup({
  preset = "classic",
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
    presets = {
      operators = false,
      montions = false,
      text_object = false,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },
  show_help = true,
  show_keys = true,
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt", "mason" },
  },
})

which_key.add({
  { "<leader>b", group = "Buffers" },
  { "<leader>c", group = "Code" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>n", group = "Notify" },
  { "<leader>p", group = "Profiler" },
  { "<leader>q", group = "Quit/Session" },
  { "<leader>t", group = "Toggle" },
  { "<leader>w", group = "Window/Save" },
  { "<leader>x", group = "Trouble/Diagnos" },
  { "<leader>y", group = "Yank" },

  { "s", group = "Split Window" },
  { "t", group = "Tabs" },
})
