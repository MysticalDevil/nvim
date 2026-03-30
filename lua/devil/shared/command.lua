local M = {}
local notify = require("devil.shared.notify")

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
      notify.info(("Started `%s` in the background, job id: %s"):format(command, job_id))
      vim.api.nvim_set_var("clj_background_pid", job_id)
      vim.g[flag_var] = true
    else
      notify.error(("Failed to start `%s`"):format(command))
    end
  end
end

function M.stop_nrepl(flag_var)
  local job_id = vim.api.nvim_get_var("clj_background_pid")

  vim.g[flag_var] = false

  if job_id and job_id > 0 then
    vim.fn.jobstop(job_id)
    notify.info("Killed nREPL background task: " .. job_id)
  end
end

return M
