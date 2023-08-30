local M = {}

function M.log(v)
  print(vim.inspect(v))
  return v
end

---@param mode string|table
---@param lhs string
---@param rhs string
---@param opts table?
function M.keymap(mode, lhs, rhs, opts)
  if type(lhs) ~= "string" then
    return
  end
  if type(rhs) ~= "string" then
    return
  end
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

return M
