local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")

local status, lspkind = pcall(require, "lspkind")
if not status then
  vim.notify("lspkind.nvim not found", "error")
  return
end

local M = {}
-- Provide parameter format for cmp.lua
M.formatting = {
  fields = {
    cmp.ItemField.Kind,
    cmp.ItemField.Abbr,
    cmp.ItemField.Menu,
  },
  format = lspkind.cmp_format({
    with_text = false,
    mode = "symbol",

    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization.
    -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
      -- Get the full snippet (and only keep first line)
      local word = entry:get_insert_text()
      if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
        word = vim.lsp.util.parse_snippet(word)
      end
      word = str.oneline(word)

      -- concatenates the string
      -- local max = 50
      -- if string.len(word) >= max then
      --   local before = string.sub(word, 1, math.floor((max - 3) / 2))
      --   word = before .. "..."
      -- end

      if
        entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
        and string.sub(vim_item.abbr, -1, -1) == "~"
      then
        word = word .. "~"
      end
      vim_item.abbr = word

      return vim_item
    end,
  }),
}

return M
