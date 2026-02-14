local create_user_command = vim.api.nvim_create_user_command
local notify = require("devil.utils.notify")

local ih = vim.lsp.inlay_hint

local function get_filter()
  return { bufnr = 0 }
end

local function toggle_inlay_hints()
  local filter = get_filter()
  local is_enabled = ih.is_enabled(filter)
  ih.enable(not is_enabled, filter)
  notify.info("Inlay Hints: " .. (not is_enabled and "Enabled" or "Disabled"))
end

local function enable_inlay_hints()
  ih.enable(true, get_filter())
end

local function disable_inlay_hints()
  ih.enable(false, get_filter())
end

create_user_command("InlayHintsToggle", toggle_inlay_hints, { desc = "Toggle inlay hints (buffer)" })
create_user_command("InlayHintsEnable", enable_inlay_hints, { desc = "Enable inlay hints (buffer)" })
create_user_command("InlayHintsDisable", disable_inlay_hints, { desc = "Disable inlay hints (buffer)" })
