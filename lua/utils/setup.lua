local M = {}

function M.log(v)
  print(vim.inspect(v))
  return v
end

---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table?
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

M.deep_print = function(tbl)
  local request_headers_all = ""
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      request_headers_all = request_headers_all .. "[" .. k .. " " .. M.deep_print(v) .. "] "
    else
      local rowtext = string.format("[%s %s] ", k, v)
      request_headers_all = request_headers_all .. rowtext
    end
  end
  return request_headers_all
end

return M
