local M = {}

local complete_util = require("complete.util")

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

---@return table
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

---@return table
function M.flags()
  return {
    debounce_text_changes = 150,
  }
end

---@return table
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

      if vim.fn.has("nvim-0.10") == 1 then
        M.set_inlay_hints(client, bufnr)
      end
    end,
  }
end

function M.set_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP Inlayhints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  if not client.server_capabilities.inlayHintProvider then
    return
  end

  if setmetatable({}, { __index = nil })[bufnr] then
    return
  end

  if client.name == "zls" then
    vim.g.zig_fmt_autosave = 0
  end

  vim.lsp.inlay_hint(bufnr)
end

function M.enable_inlay_hints_autocmd()
  vim.api.nvim_create_augroup("LspSetup_Inlayhints", {})
  vim.cmd.highlight("default link LspInlayHint Comment")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspSetup_Inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if vim.fn.has("nvim-0.10") == 1 then
        M.set_inlay_hints(client, bufnr)
      else
        require("lsp-inlayhints").on_attach(client, bufnr)
      end
    end,
  })
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

---@param server table
---@param opts table
local function setup_for_rust(server, opts)
  local ok_rt, rust_tools = pcall(require, "rust-tools")
  if not ok_rt then
    vim.notify("Failed to load rust tools, will set up `rust-analyzer` without `rust-tools`.", "warn")
    if complete_util.get_engine() == "coq" then
      server.setup(require("coq").lsp_ensure_capabilities(opts))
    else
      server.setup(opts)
    end
  else
    require("configs.plugin.rust-tools")
  end
end

---@param coq_status boolean
---@param opts table
---@return table
local function set_configs(coq_status, opts)
  if coq_status then
    return {
      on_setup = function(server)
        server.setup(require("coq").lsp_ensure_capabilities(opts))
      end,
    }
  end

  return {
    on_setup = function(server)
      server.setup(opts)
    end,
  }
end

---@param opts table
---@param lang string|nil
function M.set_on_setup(opts, lang)
  local coq_enabled = function()
    return complete_util.get_engine() == "coq"
  end

  local server_config = set_configs(coq_enabled(), opts)

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
