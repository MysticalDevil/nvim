---LSP helper utilities.
---@module devil.utils.lsp_tool

local M = {}

---@param bufnr number?
---@param should_save boolean?
---@return nil
function M.format(bufnr, should_save)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf.format({
    bufnr = bufnr,
    async = true,
    filter = function(_)
      return true
    end,
  })

  if should_save then
    vim.cmd("update")
  end
end

local proxy_lsps = {
  ["null-ls"] = true,
  ["ast_grep"] = true,
  ["efm"] = true,
}
---Check whether an LSP client is not a proxy/aggregator server.
---@param name string
---@return boolean
function M.not_proxy_lsp(name)
  return not proxy_lsps[name]
end

---Format a client name for statusline display.
---@param name string
---@return string
local function format_client_name(name)
  return ("[%s]"):format(name)
end

---Get active, non-proxy LSP client names for current buffer.
---@return string
function M.get_lsp_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if not clients or #clients == 0 then
    return "No Active LSP"
  end

  local names = {}
  for _, client in ipairs(clients) do
    if M.not_proxy_lsp(client.name) and not vim.tbl_contains(names, client.name) then
      table.insert(names, client.name)
    end
  end

  if #names == 0 then
    return "No Active LSP"
  end

  return format_client_name(table.concat(names, " "))
end

return M
