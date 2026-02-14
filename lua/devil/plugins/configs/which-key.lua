local status_ok, which_key = pcall(require, "which-key")
local notify = require("devil.utils.notify")
if not status_ok then
  notify.error("which-key.nvim not found")
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
      motions = false,
      text_objects = false,
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
  { "<leader>x", group = "Trouble/Diagnose" },
  { "<leader>y", group = "Yank" },

  { "s", group = "Split Window" },
  { "t", group = "Tabs" },
})
