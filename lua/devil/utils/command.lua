local M = {}

-- Function to start an nREPL job
---@param command string
---@param flag_var string
function M.start_nrepl(command, flag_var)
  if vim.g[flag_var] then
    return
  end

  local cwd = vim.fn.getcwd()
  local file_to_check = ""

  if string.match(command, "clj") then
    file_to_check = "deps.edn"
  elseif string.match(command, "lein") then
    file_to_check = "project.clj"
  end

  if vim.fn.filereadable(cwd .. "/" .. file_to_check) == 1 then
    local job_id = vim.fn.jobstart(command, {
      cwd = cwd,
      detach = 1,
    })
    if job_id > 0 then
      -- vim.notify(("Started `%s` in the background -- %s"):format(command, job_id), vim.log.levels.INFO)
      vim.api.nvim_set_var("clj_background_pid", job_id)
      vim.g[flag_var] = true
    else
      vim.notify(("Failed to start `%s`"):format(command), vim.log.levels.ERROR)
    end
  end
end

-- Function to stop an nREPL job
---@param flag_var string|Array
function M.stop_nrepl(flag_var)
  local job_id = vim.api.nvim_get_var("clj_background_pid")

  if type(flag_var) == "table" then
    for _, v in pairs(flag_var) do
      vim.g[v] = false
    end
  elseif flag_var == "string" then
    vim.g[flag_var] = false
  end

  if job_id and job_id > 0 then
    vim.fn.jobstop(job_id)
    vim.notify("Killed nREPL background task", vim.log.levels.INFO)
  end
end

return M
