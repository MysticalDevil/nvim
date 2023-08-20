local status, dashboard = pcall(require, "dashboard")
if not status then
  vim.notify("dashboard not found", "error")
  return
end

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
      { desc = "󰊳  Update", group = "@property", action = "Lazy update", key = "u" },
      { desc = "  Projects", group = "Label", action = "Telescope projects", key = "p" },
      {
        desc = "󰦛  Recently files",
        group = "Label",
        action = "Telescope oldfiles",
        key = "r",
      },
      {
        desc = "󰌌  Edit keybindings",
        group = "DiagnosticHint",
        action = "edit" .. vim.fn.stdpath("config") .. "/lua/configs/core/keybindings.lua",
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
    limit = 4,
  },
  default_executive = "telescope",
}

dashboard.setup(opts)
