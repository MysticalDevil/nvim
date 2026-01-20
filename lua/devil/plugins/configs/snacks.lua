return {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
   __  __           _   _           _
  |  \/  |_   _ ___| |_(_) ___ __ _| |
  | |\/| | | | / __| __| |/ __/ _` | |
  | |  | | |_| \__ \ |_| | (_| (_| | |
  |_|  |_|\__, |___/\__|_|\___\__,_|_|
          |___/
      ]],
    },
  },
  dim = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  terminal = { enabled = true },
  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = true,
      mini_diff_signs = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
  },
}
