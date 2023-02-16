function _G.requirePlugin(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(name .. " not found", "error")
    return nil
  end
  return plugin
end

function _G.log(v)
  print(vim.inspect(v))
  return v
end

function _G.keymap(mode, lhs, rhs, opts)
  if not (type(lhs) == "string") then
    return
  end
  if not (type(rhs) == "string") then
    return
  end
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end
