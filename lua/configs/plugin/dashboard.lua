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
    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
        "",
        "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
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

dashboard.setup(opts)

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
  vim.cmd.close()
  vim.api.nvim_create_autocmd("User", {
    pattern = "DashboardLoaded",
    callback = function()
      require("lazy").show()
    end,
  })
end
