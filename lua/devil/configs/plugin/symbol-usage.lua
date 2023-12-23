local status, symbol_usage = pcall(require, "symbol-usage")
if not status then
  vim.notify("symbol-usage.nvim not found", "error")
  return
end

local langs = require("symbol-usage.langs")

local SymbolKind = vim.lsp.protocol.SymbolKind

local function h(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

-- hl-groups can have any name
vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

local function text_format_bubbles(symbol)
  local res = {}

  local round_start = { "", "SymbolUsageRounding" }
  local round_end = { "", "SymbolUsageRounding" }

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(res, round_start)
    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  return res
end

local function text_format_plain_text(symbol)
  local fragments = {}

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(fragments, ("%s %s"):format(num, usage))
  end

  if symbol.definition then
    table.insert(fragments, symbol.definition .. " defs")
  end

  if symbol.implementation then
    table.insert(fragments, symbol.implementation .. " impls")
  end

  return table.concat(fragments, ", ")
end

local function text_format(symbol)
  local fragments = {}

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(fragments, ("%s %s"):format(num, usage))
  end

  if symbol.definition then
    table.insert(fragments, symbol.definition .. " defs")
  end

  if symbol.implementation then
    table.insert(fragments, symbol.implementation .. " impls")
  end

  return table.concat(fragments, ", ")
end

local filter_main_func = {
  kinds_filter = {
    [SymbolKind.Function] = {
      function(data)
        local symbol = data.symbol
        if symbol.name:lower() == "main" then
          return false
        end
        return true
      end,
    },
  },
}

local opts = {
  ---@type table<string, any> `nvim_set_hl`-like options for highlight virtual text
  hl = { link = "Comment" },
  kinds = { SymbolKind.Function, SymbolKind.Method },
  ---Additional filter for kinds. Recommended use in the filetypes override table.
  ---fiterKind: function(data: { symbol:table, parent:table, bufnr:integer }): boolean
  ---`symbol` and `parent` is an item from `textDocument/documentSymbol` request
  ---See: #filter-kinds
  kinds_filter = {},
  ---@type 'above'|'end_of_line'|'textwidth' above by default
  vt_position = "above",
  ---Text to display when request is pending. If `false`, extmark will not be
  ---created until the request is finished. Recommended to use with `above`
  ---vt_position to avoid "jumping lines".
  ---@type string|table|false
  request_pending_text = "loading...",
  ---The function can return a string to which the highlighting group from `opts.hl` is applied.
  ---Alternatively, it can return a table of tuples of the form `{ { text, hl_group }, ... }`` - in this case the specified groups will be applied.
  ---See `#format-text-examples`
  references = { enabled = true, include_declaration = false },
  definition = { enabled = false },
  implementation = { enabled = true },
  ---@type 'start'|'end' At which position of `symbol.selectionRange` the request to the lsp server should start. Default is `end` (try changing it to `start` if the symbol counting is not correct).
  symbol_request_pos = "end", -- Recommended redifine only in `filetypes` override table
  text_format = text_format_bubbles,
  filetypes = {
    lua = langs.lua,
    javascript = langs.javascript,
    typescript = langs.javascript,
    typescriptreact = langs.javascript,
    javascriptreact = langs.javascript,
    vue = langs.javascript,
    go = filter_main_func,
    java = filter_main_func,
    rust = filter_main_func,
    zig = filter_main_func,
  },
}

symbol_usage.setup(opts)
