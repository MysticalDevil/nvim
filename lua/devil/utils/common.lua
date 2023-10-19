local M = {}

-- A simple log function
---@param v any
---@return any
function M.log(v)
  print(vim.inspect(v))
  return v
end

-- Wrapper function of vim.keymap.set
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

-- Function to traverse nested tables
---@param tbl table
---@return string
function M.deep_print(tbl)
  local request_headers_all = ""
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      request_headers_all = ("%s[%s %s]"):format(request_headers_all, k, M.deep_print(v))
    else
      local rowtext = string.format("[%s %s] ", k, v)
      request_headers_all = string.format("%s%s", request_headers_all, rowtext)
    end
  end
  return request_headers_all
end

-- A full icon for lsp label kinds
M.kind_icons = {
  Array = "󰅪 ",
  Boolean = " ",
  BreakStatement = "󰙧 ",
  Call = "󰃷 ",
  CaseStatement = "󱃙 ",
  Class = " ",
  Color = "󰏘 ",
  Constant = "󰏿 ",
  Constructor = " ",
  ContinueStatement = "→ ",
  Copilot = " ",
  Declaration = "󰙠 ",
  Delete = "󰩺 ",
  DoStatement = "󰑖 ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = "󰈙 ",
  Folder = "󰉋 ",
  ForStatement = "󰑖 ",
  Function = "󰊕 ",
  H1Marker = "󰉫 ", -- Used by markdown treesitter parser
  H2Marker = "󰉬 ",
  H3Marker = "󰉭 ",
  H4Marker = "󰉮 ",
  H5Marker = "󰉯 ",
  H6Marker = "󰉰 ",
  Identifier = "󰀫 ",
  IfStatement = "󰇉 ",
  Interface = " ",
  Keyword = "󰌋 ",
  List = "󰅪 ",
  Log = "󰦪 ",
  Lsp = " ",
  Macro = "󰁌 ",
  MarkdownH1 = "󰉫 ", -- Used by builtin markdown source
  MarkdownH2 = "󰉬 ",
  MarkdownH3 = "󰉭 ",
  MarkdownH4 = "󰉮 ",
  MarkdownH5 = "󰉯 ",
  MarkdownH6 = "󰉰 ",
  Method = "󰆧 ",
  Module = "󰏗 ",
  Namespace = "󰌗 ",
  Null = "󰢤 ",
  Number = "󰎠 ",
  Object = "󰅩 ",
  Operator = "󰆕 ",
  Package = "󰆦 ",
  Pair = "󰅪 ",
  Property = " ",
  Reference = "󰦾 ",
  Regex = " ",
  Repeat = "󰑖 ",
  Scope = "󰅩 ",
  Snippet = "󰩫 ",
  Specifier = "󰦪 ",
  Statement = "󰅩 ",
  String = " ",
  Text = "󰉿 ",
  Unit = "󰑭 ",
  Value = "󰎠 ",
  Variable = " ",
  Struct = " ",
  TypeParameter = "󰊄 ",
}

return M
