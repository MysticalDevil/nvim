local dapui = require("dapui")
local dap = require("dap")

dapui.setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {
    scopes = {
      open = "<CR>",
      edit = "e",
      expand = "o",
      repl = "r",
    },
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  force_buffers = true,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.4 },
        "stacks",
        "watches",
        "breakpoints",
        "console",
      },
      size = 0.35, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
      },
      size = 0.25, -- %25 of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  controls = {
    enabled = vim.fn.exists("+winbar") == 1,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
      disconnect = "",
    },
  },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
    indent = 1,
  },
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

--https://github.com/mfussenegger/nvim-dap/discussions/355

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

--
vim.fn.sign_define("DapBreakpoint", {
  text = "󰝥",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "󰟃",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DapLogPoint",
  linehl = "DapLogPoint",
  numhl = "DapLogPoint",
})

vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DapStopped",
  linehl = "DapStopped",
  numhl = "DapStopped",
})
