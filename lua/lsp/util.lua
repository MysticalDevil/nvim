local M = {}

function M.key_attach(bufnr)
  local function buf_set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end
  -- keybingings
  require("configs.core.keybindings").map_LSP(buf_set_keymap)
end

-- disable format, handle it to a dedicated plugin
function M.disable_format(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

function M.common_capabilities()
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

function M.flags()
  return {
    debounce_text_changes = 150,
  }
end

function M.default_configs()
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
function M.find_binary_exists(name)
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
function M.node_installed()
  return M.find_binary_exists("npm")
end

---@return boolean
function M.rust_installed()
  return M.find_binary_exists("cargo")
end

---@return boolean
function M.go_installed()
  return M.find_binary_exists("go")
end

---@return boolean
function M.python_installed()
  return M.find_binary_exists({ "pip", "pip3" })
end

---@return boolean
function M.ruby_installed()
  return M.find_binary_exists("gem")
end

---@return string
function M.check_os()
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
---@param lang string|nil
function M.set_on_setup(opts, lang)
  local server_config = {
    on_setup = function(server)
      server.setup(opts)
    end,
  }

  if lang == "rust" then
    server_config.on_setup = function(server)
      setup_for_rust(server, opts)
    end
  end

  if lang == "lua" then
    server_config.on_setup = function(server)
      require("neodev").setup()
      server.setup(opts)
    end
  end

  return server_config
end

return M
