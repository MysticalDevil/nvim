local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("lazy.nvim not install", "error")
  return
end

local plugins_list = {
  require("devil.plugins.colorscheme"),
  require("devil.plugins.common"),
  require("devil.plugins.git"),
  require("devil.plugins.prog"),
}

local opts = {
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
}

lazy.setup(plugins_list, opts)
