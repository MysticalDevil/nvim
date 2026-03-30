local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

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

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
