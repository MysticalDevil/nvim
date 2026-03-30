local notify = nil
do
  local ok, loaded = pcall(require, "devil.shared.notify")
  if ok then
    notify = loaded
  end
end

local function emit(msg, level)
  if notify then
    notify.notify(msg, level)
  else
    vim.notify(msg, level)
  end
end

if vim.fn.has("nvim-0.11") ~= 1 then
  emit("This config is only available on Neovim >= 0.11", vim.log.levels.ERROR)
  return
end

-- Gentoo commonly ships extra Vim runtime files in this path.
-- Keep it in runtimepath for compatibility with system-wide Vim plugins/scripts.
if vim.uv.os_uname().release:match("gentoo") then
  vim.opt.rtp:append("/usr/share/vim/vimfiles")
end

---Load module safely and notify on failure.
---@param module string
---@param level? integer
---@return any|nil
local function safe_require(module, level)
  local ok, loaded = pcall(require, module)
  if not ok then
    emit(("Failed to load `%s`: %s"):format(module, loaded), level or vim.log.levels.WARN)
    return nil
  end
  return loaded
end

safe_require("devil.core", vim.log.levels.ERROR)
local mappings = safe_require("devil.core.mappings", vim.log.levels.ERROR)
if mappings and type(mappings.setup_early_mappings) == "function" then
  mappings.setup_early_mappings()
end

safe_require("devil.core.bootstrap", vim.log.levels.ERROR)
safe_require("devil.plugins", vim.log.levels.ERROR)

local app = safe_require("devil.app", vim.log.levels.ERROR)
if app and type(app.setup) == "function" then
  app.setup()
end
