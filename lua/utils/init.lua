local M = {}

function M.log(v)
  print(vim.inspect(v))
  return v
end

---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table?
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

M.deep_print = function(tbl)
  local request_headers_all = ""
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      request_headers_all = request_headers_all .. "[" .. k .. " " .. M.deep_print(v) .. "] "
    else
      local rowtext = string.format("[%s %s] ", k, v)
      request_headers_all = request_headers_all .. rowtext
    end
  end
  return request_headers_all
end

function M.async_formatting(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params({}), function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("silent noautocmd update")
      end)
    end
  end)
end

---@param name string
local function not_proxy_lsp(name)
  return name ~= "null-ls" and name ~= "efm"
end

local non_proxy_clients = {}

M.get_lsp_info = function()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

  local clients = vim.lsp.get_active_clients()
  if not clients then
    non_proxy_clients = {}
    clients = vim.lsp.get_active_clients()
  end

  local cached_client = non_proxy_clients[buf_ft]
  if cached_client then
    return cached_client.name
  end

  for _, client in ipairs(clients) do
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
      if not_proxy_lsp(client.name) then
        non_proxy_clients[buf_ft] = client
        return client.name
      end
    end
  end

  return "No Active LSP"
end

local lsp_count = {}
-- calculate number of references for entity under cursor asynchronously
---@async
local function request_lsp_ref_count()
  if vim.fn.mode ~= "n" then
    lsp_count = {}
    return
  end

  local params = vim.lsp.util.make_position_params(0) ---@diagnotics disable-line: missing-parameter
  params.context = { includeDecleration = false }

  local this_file_uri = vim.uri_from_fname(vim.fn.expand("%:p"))

  vim.lsp.buf_request(0, "textDocument/references", params, function(error, refs)
    lsp_count.ref_file = 0
    lsp_count.ref_workspace = 0
    if not error and refs then
      lsp_count.ref_workspace = #refs
      for _, ref in pairs(refs) do
        if this_file_uri == ref.uri then
          lsp_count.ref_file = lsp_count.ref_file + 1
        end
      end
    end
  end)

  vim.lsp.buf_request(0, "textDocument/defination", params, function(error, defs)
    lsp_count.def_file = 0
    lsp_count.def_workspace = 0
    if not error and defs then
      lsp_count.def_workspace = #defs
      for _, def in pairs(defs) do
        if this_file_uri == def.targetUri then
          lsp_count.def_file = lsp_count.def_file + 1
        end
      end
    end
  end)
end

---shows the number of definitions/references as identified by LSP. Shows count
---for the current file and for the whole workspace.
---@return string statusline text
---@nodiscard
function M.lsp_count()
  -- abort when lsp loading or not capable of references
  local current_bufnr = vim.fn.bufnr()
  local buf_clients = vim.lsp.get_active_clients({ bufnr = current_bufnr })
  local lsp_progress = (vim.version().minor > 9 and vim.version().major == 0) and vim.lsp.status()
    or vim.lsp.util.get_progress_messages()
  local lsp_loading = lsp_progress.title and lsp_progress.title:find("[Ll]oad")
  local lsp_capable = false
  for _, client in pairs(buf_clients) do
    local capable = client.server_capabilities
    if capable.referencesProvider and capable.definationProvider then
      lsp_capable = true
    end
  end
  if vim.api.nvim_get_mode() ~= "n" or lsp_loading or not lsp_capable then
    return ""
  end

  -- trigger count, abort when none
  request_lsp_ref_count() -- needs to be separated due to lsp calls being async
  vim.notify(lsp_count)
  if lsp_count.ref_workspace == 0 and lsp_count.def_workspace == 0 then
    return ""
  end
  if not lsp_count.ref_workspace then
    return ""
  end

  -- format lsp references/definitions count to be displayed in the status bar
  local defs, refs = "", ""
  if lsp_count.def_workspace then
    defs = tostring(lsp_count.def_file)
    if lsp_count.def_file ~= lsp_count.def_workspace then
      defs = defs .. "(" .. tostring(lsp_count.def_workspace) .. ")"
    end
    defs = defs .. "D"
  end
  if lsp_count.ref_workspace then
    refs = tostring(lsp_count.ref_file)
    if lsp_count.ref_file ~= lsp_count.ref_workspace then
      refs = refs .. "(" .. tostring(lsp_count.ref_workspace) .. ")"
    end
    refs = refs .. "R"
  end

  vim.nofity("not break")
  return "LSP: " .. defs .. " " .. refs
end

return M
