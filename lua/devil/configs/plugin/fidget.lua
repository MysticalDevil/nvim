local status, fidget = pcall(require, "fidget")
if not status then
  vim.notify("fidget not found", "error")
  return
end

local opts = {
  -- Options related to LSP progress subsystem
  progress = {
    poll_rate = 5, -- How frequently to poll for progress messages
    -- How to get a progress message's notification group key
    notification_group = function(msg)
      return msg.lsp_name
    end,
    ignore = {}, -- List of LSP servers to ignore

    -- Options related to how LSP progress messages are displayed as notifications
    display = {
      done_ttl = 3, -- How long a message should persist after completion
      done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
      done_style = "Constant", -- Highlight group for completed LSP tasks
      progress_ttl = math.huge, -- How long a message should persist when in progress
      -- Icon shown when LSP progress tasks are in progress
      progress_icon = { pattern = "dots", period = 1 },
      -- Highlight group for in-progress LSP tasks
      progress_style = "WarningMsg",
      group_style = "Title", -- Highlight group for group name (LSP server name)
      icon_style = "Question", -- Highlight group for group icons
      priority = 30, -- Ordering priority for LSP notification group
      -- How to format a progress message
      format_message = require("fidget.progress.display").default_format_message,
      -- How to format a progress annotation
      format_annote = function(msg)
        return msg.title
      end,
      -- How to format a progress notification group's name
      format_group_name = function(group)
        return tostring(group)
      end,
      overrides = { -- Override options from the default notification config
        rust_analyzer = { name = "rust-analyzer" },
      },
    },
  },

  -- Options related to notification subsystem
  notification = {
    poll_rate = 10, -- How frequently to poll and render notifications

    -- Options related to how notifications are rendered as text
    view = {
      icon_separator = " ", -- Separator between group name and icon
      group_separator = "---", -- Separator between notification groups
      -- Highlight group used for group separator
      group_separator_hl = "Comment",
    },

    -- Options related to the notification window and buffer
    window = {
      normal_hl = "Comment", -- Base highlight group in the notification window
      winblend = 100, -- Background color opacity in the notification window
      border = "none", -- Border around the notification window
      zindex = 45, -- Stacking priority of the notification window
      max_width = 0, -- Maximum width of the notification window
      max_height = 0, -- Maximum height of the notification window
      x_padding = 1, -- Padding from right edge of window boundary
      y_padding = 0, -- Padding from bottom edge of window boundary
    },
  },

  -- Options related to logging
  logger = {
    level = vim.log.levels.WARN, -- Minimum logging level
    float_precision = 0.01, -- Limit the number of decimals displayed for floats
  },
}

fidget.setup(opts)
