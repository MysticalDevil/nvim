---Aggregated utility module.
---@module devil.utils

local common = require("devil.utils.common")
local lsp_tool = require("devil.utils.lsp_tool")
local command = require("devil.utils.command")
local notify = require("devil.utils.notify")

local M = {
  common = common or {},
  lsp_tool = lsp_tool or {},
  command = command or {},
  notify = notify or {},
}

local collisions = {}

local function export_module(module_name, module)
  for k, v in pairs(module) do
    if M[k] == nil then
      M[k] = v
    elseif M[k] ~= v then
      table.insert(collisions, ("%s.%s"):format(module_name, k))
    end
  end
end

export_module("common", M.common)
export_module("lsp_tool", M.lsp_tool)
export_module("command", M.command)
export_module("notify", M.notify)

if #collisions > 0 then
  vim.schedule(function()
    vim.notify(
      ("utils export collisions ignored (kept first definition): %s"):format(table.concat(collisions, ", ")),
      vim.log.levels.WARN
    )
  end)
end

return M
