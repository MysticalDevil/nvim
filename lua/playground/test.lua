local function deep_print(t)
  local request_headers_all = ""
  for k, v in pairs(t) do
    if type(v) == "table" then
      request_headers_all = request_headers_all .. "[" .. k .. " " .. deep_print(v) .. "] "
    else
      local rowtext = string.format("[%s %s] ", k, v)
      request_headers_all = request_headers_all .. rowtext
    end
  end
  return request_headers_all
end

local function get_lsp_name()
  local msg = "No Active LSP"

  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

print(get_lsp_name())
