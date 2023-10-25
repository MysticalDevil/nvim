local M = {}

-- Function to formatting code asynchronously
---@param bufnr number
function M.async_formatting(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params({}), function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify(("formatting: %s"):format(err_msg), vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
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

-- Determine whether the obtained LSP is a proxy LSP
---@param name string
---@return boolean
local function not_proxy_lsp(name)
  return name ~= "null-ls" and name ~= "efm"
end

-- Format getted LSP name
---@param name string
---@return string
local function format_client_name(name)
  return ("[%s]"):format(name)
end

local non_proxy_clients = {}

-- Function to get current activated LSP name
---@return string
function M.get_lsp_info()
  local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })

  local clients = vim.lsp.get_clients()
  if not clients then
    non_proxy_clients = {}
    clients = vim.lsp.get_clients()
  end

  local cached_client = non_proxy_clients[buf_ft]
  if cached_client then
    return format_client_name(cached_client.name)
  end

  for _, client in ipairs(clients) do
    if client.config["filetypes"] and vim.tbl_contains(client.config["filetypes"], buf_ft) then
      if not_proxy_lsp(client.name) then
        non_proxy_clients[buf_ft] = client
        return format_client_name(client.name)
      end
    end
  end

  return "No Active LSP"
end

return M
