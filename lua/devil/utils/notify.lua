---Notification helpers with centralized noise control.
---@module devil.utils.notify

local M = {}

local function min_level()
  local ok, settings = pcall(require, "devil.core.settings")
  if ok and settings.notify and settings.notify.min_level then
    return settings.notify.min_level
  end
  return vim.log.levels.INFO
end

---Notify if level passes configured threshold.
---@param msg string
---@param level? integer
---@param opts? table
function M.notify(msg, level, opts)
  level = level or vim.log.levels.INFO
  if level < min_level() then
    return
  end
  vim.notify(msg, level, opts or {})
end

---@param msg string
---@param opts? table
function M.debug(msg, opts)
  M.notify(msg, vim.log.levels.DEBUG, opts)
end

---@param msg string
---@param opts? table
function M.info(msg, opts)
  M.notify(msg, vim.log.levels.INFO, opts)
end

---@param msg string
---@param opts? table
function M.warn(msg, opts)
  M.notify(msg, vim.log.levels.WARN, opts)
end

---@param msg string
---@param opts? table
function M.error(msg, opts)
  M.notify(msg, vim.log.levels.ERROR, opts)
end

return M
