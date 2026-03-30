---Helpers for Gentoo ebuild related commands.

local M = {}
local notify = require("devil.shared.notify")

---@param cmd string[]
---@param cwd string
---@param title string
local function run_to_qf(cmd, cwd, title)
  local output = {}

  local function on_event(_, data, _)
    if not data then
      return
    end
    for _, line in ipairs(data) do
      if line ~= "" then
        table.insert(output, line)
      end
    end
  end

  local job_id = vim.fn.jobstart(cmd, {
    cwd = cwd,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = on_event,
    on_stderr = on_event,
    on_exit = function(_, code, _)
      local items = {}
      for _, line in ipairs(output) do
        table.insert(items, { text = line })
      end

      vim.fn.setqflist({}, " ", {
        title = string.format("%s (exit=%d)", title, code),
        items = items,
      })
      vim.cmd("copen")
      if code ~= 0 then
        notify.warn(string.format("%s failed (exit=%d)", title, code))
      end
    end,
  })

  if job_id <= 0 then
    notify.error("failed to start job: " .. table.concat(cmd, " "))
  end
end

---@return string
local function buf_dir()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return vim.uv.cwd()
  end
  return vim.fn.fnamemodify(name, ":p:h")
end

---@param bin string
---@return string|nil
local function exepath(bin)
  local path = vim.fn.exepath(bin)
  if path ~= nil and path ~= "" then
    return path
  end
  return nil
end

---@param bin string
---@return string|nil
local function mason_bin(bin)
  local path = vim.fn.stdpath("data") .. "/mason/bin/" .. bin
  if vim.uv.fs_stat(path) then
    return path
  end
  return nil
end

---@param bin string
---@return string
local function find_bin(bin)
  return exepath(bin) or mason_bin(bin) or bin
end

function M.pkg_manifest()
  run_to_qf({ find_bin("pkgdev"), "manifest" }, buf_dir(), "pkgdev manifest")
end

function M.pkg_check()
  run_to_qf({ find_bin("pkgcheck"), "scan" }, buf_dir(), "pkgcheck scan")
end

return M
