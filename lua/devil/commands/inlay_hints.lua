local create_user_command = vim.api.nvim_create_user_command

local inlay_hint = vim.lsp.inlay_hint

local function toggle_inlay_hints()
  if inlay_hint.is_enabled() then
    inlay_hint.enable(nil, false)
  else
    inlay_hint.enable(nil, true)
  end
end

local function enable_inlay_hints()
  if not inlay_hint.is_enabled() then
    inlay_hint.enable(nil, true)
  end
end

local function disable_inlay_hints()
  if inlay_hint.is_enabled() then
    inlay_hint.enable(nil, false)
  end
end

create_user_command("InlayHintsToggle", toggle_inlay_hints, { desc = "Enable/Disable inlay hints on current buffer" })
create_user_command("InlayHintsEnable", enable_inlay_hints, { desc = "Enable/Disable inlay hints on current buffer" })
create_user_command("InlayHintsDisable", disable_inlay_hints, { desc = "Enable/Disable inlay hints on current buffer" })
