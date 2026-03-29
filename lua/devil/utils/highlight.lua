---Highlight helpers for deriving plugin colors from the active colorscheme.
---@module devil.utils.highlight

local M = {}

---@param value integer|string|nil
---@return string|nil
local function to_hex(value)
  if type(value) == "number" then
    return ("#%06x"):format(value)
  end
  return value
end

---@param group string
---@return table
function M.get(group)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = true })
  if not ok or type(hl) ~= "table" then
    return {}
  end

  local normalized = {}
  for key, value in pairs(hl) do
    normalized[key] = to_hex(value)
  end
  return normalized
end

---@param group string
---@param attr string
---@return string|nil
function M.attr(group, attr)
  return M.get(group)[attr]
end

---@param specs table[]
---@param fallback? string
---@return string|nil
function M.first(specs, fallback)
  for _, spec in ipairs(specs) do
    local group = spec[1]
    local attr = spec[2] or "fg"
    local value = M.attr(group, attr)
    if value ~= nil then
      return value
    end
  end
  return fallback
end

---@param opts table
---@return table
function M.style(opts)
  local style = vim.deepcopy(opts.extra or {})

  if opts.fg then
    style.fg = M.first(opts.fg, style.fg)
  end
  if opts.bg then
    style.bg = M.first(opts.bg, style.bg)
  end
  if opts.sp then
    style.sp = M.first(opts.sp, style.sp)
  end

  return style
end

return M
