local M = {}

---@param bufnr number?
---@param should_save boolean?
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
-- Determine whether the obtained LSP is a proxy LSP
---@param name string
---@return boolean
function M.not_proxy_lsp(name)
  return not proxy_lsps[name]
end

-- Format getted LSP name
---@param name string
---@return string
local function format_client_name(name)
  return ("[%s]"):format(name)
end

-- Function to get current activated LSP name
---@return string
function M.get_lsp_info()
  local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })

  local clients = vim.lsp.get_clients()
  if not clients then
    return "No Active LSP"
  end

  local lsp_names = {}
  for _, client in ipairs(clients) do
    if client.config["filetypes"] and vim.tbl_contains(client.config["filetypes"], buf_ft) then
      if M.not_proxy_lsp(client.name) and not vim.tbl_contains(lsp_names, client.name) then
        table.insert(lsp_names, client.name)
      end
    end
  end

  if #lsp_names > 0 then
    return format_client_name(table.concat(lsp_names, " "))
  else
    return "No Active LSP"
  end
end

return M
