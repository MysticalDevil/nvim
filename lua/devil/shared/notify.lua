local M = {}

local function min_level()
  local ok, settings = pcall(require, "devil.config.notify")
  if ok and settings.min_level then
    return settings.min_level
  end
  return vim.log.levels.INFO
end

function M.notify(msg, level, opts)
  level = level or vim.log.levels.INFO
  if level < min_level() then
    return
  end
  vim.notify(msg, level, opts or {})
end

function M.debug(msg, opts)
  M.notify(msg, vim.log.levels.DEBUG, opts)
end

function M.info(msg, opts)
  M.notify(msg, vim.log.levels.INFO, opts)
end

function M.warn(msg, opts)
  M.notify(msg, vim.log.levels.WARN, opts)
end

function M.error(msg, opts)
  M.notify(msg, vim.log.levels.ERROR, opts)
end

return M
