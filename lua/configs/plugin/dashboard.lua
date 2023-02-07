local status, dashboard = pcall(require, "dashboard")
if not status then
  vim.notify("dashboard not found", "error")
  return
end

dashboard.default_executive = "telescope"

local opts = {
  theme = "hyper",
  config = {
    header = {
      [[]],
      [[]],
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[]],
      [[]],
    },
    footer = {
      "",
      "https://github.com/MysticalDevil",
    },
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = "  Update", group = "@property", action = "LazySync", key = "u" },
      { desc = "  Projects", group = "Label", action = "Telescope projects", key = "p" },
      {
        desc = "ﮦ  Recently files",
        group = "Label",
        action = "Telescope oldfiles",
        key = "r",
      },
      {
        desc = "  Dotfiles",
        group = "Number",
        action = "Telescope dotfiles",
        key = "d",
      },
      {
        desc = "  Edit keybindings",
        group = "DiagnosticHint",
        action = "edit ~/.config/nvim/lua/configs/core/keybindings.lua",
        key = "ek",
      },
    },
  },
  hide = {
    tabline = true,
    statusline = false,
    winbar = true,
  },
  project = {
    limit = 6,
  },
}

dashboard.setup(opts)
