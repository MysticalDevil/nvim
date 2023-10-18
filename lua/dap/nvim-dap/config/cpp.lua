local M = {}

function M.setup()
  local dap = require("dap")

  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    -- change to your path
    -- if can not find OpenDebugAD7, please install cpptools by mason
    command = ("%s/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"):format(vim.fn.stdpath("data")),
  }
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = ("%s/mason/bin/codelldb"):format(vim.fn.stdpath("data")),
      args = { "--port", "${port}" },
    },
  }

  local cpptools_config = { ---@diagnostic disable-line
    -- launch exe
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", ("%s/"):format(vim.fn.getcwd()), "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
    -- attach process
    {
      name = "Attach process",
      type = "cppdbg",
      request = "attach",
      processId = require("dap.utils").pick_process,
      program = function()
        return vim.fn.input("Path to executable: ", ("%s/"):format(vim.fn.getcwd()), "file")
      end,
      cwd = "${workspaceFolder}",
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
    -- attach server
    {
      name = "Attach to gdbserver :1234",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/gdb",
      cwd = "${workspaceFolder}",
      program = function()
        return vim.fn.input("Path to executable: ", ("%s/"):format(vim.fn.getcwd()), "file")
      end,
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
  }

  local codelldb_config = {
    {
      name = "Launch File",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", ("%s/"):format(vim.fn.getcwd()), "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  -- setup other language
  dap.configurations.c = codelldb_config
  dap.configurations.cpp = codelldb_config
end

return M
