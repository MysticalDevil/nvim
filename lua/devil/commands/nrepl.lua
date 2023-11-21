local util = require("devil.utils")
local create_user_command = vim.api.nvim_create_user_command

local function check_cwd_content()
  local cwd = vim.fn.getcwd()

  if vim.fn.filereadable(cwd .. "/deps.edn") == 1 then
    return "native"
  elseif vim.fn.filereadable(cwd .. "/project.clj") == 1 then
    return "leinigen"
  else
    return nil
  end
end

local function nrepl_start()
  local project_type = check_cwd_content()
  if project_type then
    if project_type == "native" then
      util.start_nrepl("clj -M:repl/conjure", "clj_job_started")
    elseif project_type == "leinigen" then
      util.start_nrepl("lein repl", "lein_job_started")
    end
  end
end

local function nrepl_stop()
  local project_type = check_cwd_content()
  if project_type then
    if project_type == "native" then
      util.stop_nrepl("clj_job_started")
    elseif project_type == "leinigen" then
      util.stop_nrepl("lein_job_started")
    end
  end
end

local function nrepl_restart()
  nrepl_stop()
  nrepl_start()
end

create_user_command("NReplStart", nrepl_start, { desc = "Start nREPL server in clojure project" })
create_user_command("NReplRestart", nrepl_restart, { desc = "Start nREPL server in clojure project" })
create_user_command("NReplStop", nrepl_stop, { desc = "Start nREPL server in clojure project" })
