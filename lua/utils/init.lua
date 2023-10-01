local M = {}

---@param name string
local function not_proxy_lsp(name)
  if name == "null-ls" or name == "efm" then
    return false
  end
  return true
end

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

function M.get_lsp_info()
  local msg = "No Active LSP"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  if #clients == 1 and not_proxy_lsp(clients[1].name) then
    return clients[1].name
  end

  if #clients == 2 then
    if not_proxy_lsp(clients[1].name) then
      return clients[1].name
    end
    if not_proxy_lsp(clients[2].name) then
      return clients[2].name
    end
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and not_proxy_lsp(client.name) then
      return client.name
    end
  end
  return msg
end

return M
