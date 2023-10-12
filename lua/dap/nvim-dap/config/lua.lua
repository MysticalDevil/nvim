local M = {}

function M.setup()
  local dap = require("dap")
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input("Host [127.0.0.1]: ")
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: ", "54321"))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.adapters.nlua = function(callback, conf)
    local adapter = {
      type = "server",
      host = conf.host or "127.0.0.1",
      port = conf.port or 8086,
    }
    if conf.start_neovim then
      local dap_run = dap.run
      dap.run = function(c)
        adapter.port = c.port
        adapter.host = c.host
      end
      require("osv").run_this()
      dap.run = dap_run
    end
    callback(adapter)
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Run this file",
      start_neovim = {},
    },
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance (port = 8086)",
      port = 8086,
    },
  }
end

function M.open()
  require("osv").run_this()
end

return M
