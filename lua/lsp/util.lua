local M = {}

M.key_attach = function(bufnr)
  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end
  -- keybingings
  require("configs.core.keybindings").map_LSP(buf_set_keymap)
end

-- disable format, handle it to a dedicated plugin
M.disable_format = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.common_capabilities = function()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

M.flags = function()
  return {
    debounce_text_changes = 150,
  }
end

M.default_configs = function()
  return {
    capabilities = M.common_capabilities(),
    flags = M.flags(),
    on_attach = function(client, bufnr)
      M.disable_format(client)
      M.key_attach(bufnr)

      vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()")
      vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc")
      vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc")
    end,
  }
end

---@param name string|table
---@return boolean
M.find_binary_exists = function(name)
  if type(name) == "table" then
    for _, bin in ipairs(name) do
      if vim.fn.executable(bin) == 1 then
        return true
      end
    end
    return false
  elseif type(name) == "string" then
    return vim.fn.executable(name) == 1
  end
  return false
end

---@return boolean
M.node_installed = function()
  return M.find_binary_exists("npm")
end

---@return boolean
M.rust_installed = function()
  return M.find_binary_exists("cargo")
end

---@return boolean
M.go_installed = function()
  return M.find_binary_exists("go")
end

---@return boolean
M.python_installed = function()
  return M.find_binary_exists({ "pip", "pip3" })
end

---@return boolean
M.ruby_installed = function()
  return M.find_binary_exists("gem")
end

---@return string
M.check_os = function()
  return vim.loop.os_uname().sysname
end

local function setup_for_rust(server, opts)
  local ok_rt, rust_tools = pcall(require, "rust-tools")
  if not ok_rt then
    vim.notify("Failed to load rust tools, will set up `rust-analyzer` without `rust-tools`.", "warn")
    server.setup(opts)
  else
    rust_tools.setup({
      server = server,
      dap = require("dap.nvim-dap.config.rust"),
    })
  end
end

---@param opts table
---@param engine string|nil
---@param lang string|nil
M.set_on_setup = function(opts, engine, lang)
  local server_config = {
    on_setup = function(server)
      server.setup(opts)
    end,
  }

  if engine == "coq" then
    local coq_capabilities = require("coq").lsp_ensure_capabilities(opts)
    if lang == "rust" then
      server_config.on_setup = function(server)
        setup_for_rust(server, coq_capabilities)
      end
    else
      server_config.on_setup = function(server)
        server.setup(coq_capabilities)
      end
    end
  elseif lang == "rust" then
    server_config.on_setup = function(server)
      setup_for_rust(server, opts)
    end
  end

  return server_config
end

return M
