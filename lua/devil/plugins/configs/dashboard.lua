return {
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
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
        "",
        ("⚡ Neovim loaded %s/%s plugins in %sms"):format(stats.loaded, stats.count, ms),
        " https://github.com/MysticalDevil",
      }
    end,
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = " Update", icon = "󰊳 ", action = "Lazy update", key = "u" },
      { desc = " New file", icon = " ", action = "ene | startinsert", key = "n" },
      { desc = " Projects", icon = " ", action = "Telescope projects", key = "p" },
      { desc = " Recently files", icon = "󰦛 ", action = "Telescope oldfiles", key = "r" },
      { desc = " Quit", icon = " ", action = "qa", key = "q" },
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
