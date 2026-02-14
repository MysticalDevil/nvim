---Helpers for Gentoo ebuild related commands.
---@module devil.utils.ebuild_cmds

local M = {}

---Run a command and forward buffered output to quickfix.
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
        vim.notify(string.format("%s failed (exit=%d)", title, code), vim.log.levels.WARN)
      end
    end,
  })

  if job_id <= 0 then
    vim.notify("failed to start job: " .. table.concat(cmd, " "), vim.log.levels.ERROR)
  end
end

---Get current buffer directory or current working directory.
---@return string
local function buf_dir()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return vim.uv.cwd()
  end
  return vim.fn.fnamemodify(name, ":p:h")
end

---Find executable in PATH.
---@param bin string
---@return string|nil
local function exepath(bin)
  local p = vim.fn.exepath(bin)
  if p ~= nil and p ~= "" then
    return p
  end
  return nil
end

---Find executable from mason bin directory.
---@param bin string
---@return string|nil
local function mason_bin(bin)
  local p = vim.fn.stdpath("data") .. "/mason/bin/" .. bin
  if vim.uv.fs_stat(p) then
    return p
  end
  return nil
end

---Resolve executable path with PATH -> mason -> raw binary fallback.
---@param bin string
---@return string
local function find_bin(bin)
  return exepath(bin) or mason_bin(bin) or bin
end

---Run `pkgdev manifest` in current buffer directory.
---@return nil
function M.pkg_manifest()
  local cwd = buf_dir()
  run_to_qf({ find_bin("pkgdev"), "manifest" }, cwd, "pkgdev manifest")
end

---Run `pkgcheck scan` in current buffer directory.
---@return nil
function M.pkg_check()
  local cwd = buf_dir()
  run_to_qf({ find_bin("pkgcheck"), "scan" }, cwd, "pkgcheck scan")
end

return M
