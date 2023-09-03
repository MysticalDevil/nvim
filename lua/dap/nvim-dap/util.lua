local status, dap = pcall(require, "dap")
if not status then
  return
end

local ui_status, _ = pcall(require, "dapui")
if not ui_status then
  return
end

local sys_utils = require("utils.setup")

local M = {}

M.keyAttach = function()
  -- run
  sys_utils.keymap("n", "<leader>dc", function()
    dap.continue({})
  end)

  --  stepOver, stepInto, stepOut,
  sys_utils.keymap("n", "<leader>dj", function()
    dap.step_over()
  end)
  sys_utils.keymap("n", "<leader>di", function()
    dap.step_into()
  end)
  sys_utils.keymap("n", "<leader>do", function()
    dap.step_out()
  end)

  -- set breakpoint
  sys_utils.keymap("n", "<leader>dt", function()
    dap.toggle_breakpoint()
  end)
  sys_utils.keymap("n", "<leader>dT", function()
    dap.clear_breakpoints()
  end)

  -- popup
  sys_utils.keymap("n", "<leader>dh", function()
    dap.eval()
  end)

  -- end

  sys_utils.keymap("n", "<leader>de", function()
    dap.terminate()
  end)

  -- rust
  -- sys_utils.keymap("n", "<leader>dd", ":RustDebuggables<CR>", opt)
end

return M
