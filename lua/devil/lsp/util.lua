local M = {}

local complete_util = require("devil.complete.util")

local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

function M.key_attach(bufnr)
  ---@param opts table?
  local function buf_set_keymap(mode, lhs, rhs, opts)
    local default_opts = {
      noremap = true,
      silent = true,
      buffer = bufnr,
    }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
  end
  -- keybingings
  require("devil.configs.core.keybindings").map_LSP(buf_set_keymap, bufnr)

  -- vim.notify("The LSP key settings is attached", vim.log.levels.INFO)
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

  return vim.lsp.protocol.make_client_capabilities()
end

---@return table
function M.flags()
  return {
    debounce_text_changes = 150,
  }
end

function M.default_on_attach(client, bufnr)
  M.disable_format(client)
  M.key_attach(bufnr)

  M.set_inlay_hints(client, bufnr)

  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
end

---@return table
function M.default_configs()
  return {
    capabilities = M.common_capabilities(),
    flags = M.flags(),
    on_attach = M.default_on_attach,
  }
end

function M.set_inlay_hints(client, bufnr)
  if not client then
    vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
    return
  end

  if client.name == "zls" then
    vim.g.zig_fmt_autosave = 1
  end

  if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
    inlay_hint(bufnr, true)
  end
end

function M.enable_inlay_hints_autocmd()
  vim.api.nvim_create_augroup("LspSetup_Inlayhints", { clear = true })
  vim.cmd.highlight("default link LspInlayHint Comment")

  vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspSetup_Inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client then
        if client.name == "null-ls" then
          return
        end

        M.set_inlay_hints(client, bufnr)
      end
    end,
  })
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
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
  local ok_rt, _ = pcall(require, "rust-tools")
  if not ok_rt then
    vim.notify("Failed to load rust tools, will set up `rust-analyzer` without `rust-tools`.", "warn")
    if complete_util.get_engine() == "coq" then
      server.setup(require("coq").lsp_ensure_capabilities(opts))
    else
      server.setup(opts)
    end
  else
    require("devil.configs.plugin.rust-tools")
  end
end

---@param server table
---@param opts table
local function setup_for_typescript(server, opts)
  local ok_ts, _ = pcall(require, "typescript-tools")

  if not ok_ts then
    vim.notify("Failed to load typescript tools, setting up tsserver without typescript-tools.", "warn")
  end

  if complete_util.get_engine() == "coq" then
    opts = require("coq").lsp_ensure_capabilities(opts)
  end

  server.setup(opts)

  if ok_ts then
    require("devil.configs.plugin.typescript-tools")
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

  if lang == "typescript" then
    server_config.on_setup = function(server)
      setup_for_typescript(server, opts)
    end
  end

  return server_config
end

return M
