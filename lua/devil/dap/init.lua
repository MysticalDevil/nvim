local M = {}

function M.setup()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end
  local signs = {
    DapBreakpoint = { text = "", texthl = "DiagnosticSignError" },
    DapBreakpointCondition = { text = "", texthl = "DiagnosticSignWarn" },
    DapLogPoint = { text = "󰰐", texthl = "DiagnosticSignInfo" },
    DapStopped = { text = "󰁕", texthl = "DiagnosticSignHint", linehl = "Visual" },
    DapBreakpointRejected = { text = "", texthl = "DiagnosticSignInfo" },
  }

  for type, icon in pairs(signs) do
    vim.fn.sign_define(type, {
      text = icon.text,
      texthl = icon.texthl,
      linehl = icon.linehl,
      numhl = "",
    })
  end

  require("devil.dap.ui").setup()

  local debug_configs = {
    "cxx",
    "go",
    "lua",
  }

  for _, name in ipairs(debug_configs) do
    local ok, config = pcall(require, "devil.dap.config." .. name)
    if not ok then
      vim.notify("DAP: Failed to load config for " .. name, vim.log.levels.ERROR)
    else
      if config.adapters then
        for adapter_name, adapter_config in pairs(config.adapters) do
          dap.adapters[adapter_name] = adapter_config
        end
      end
      if config.configurations then
        for filetype, launch_configs in pairs(config.configurations) do
          dap.configurations[filetype] = launch_configs
        end
      end
    end
  end
end

return M
