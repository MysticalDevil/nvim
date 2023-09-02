local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
  format = require("lspkind").cmp_format({
    mode = "symbol_text",
    -- mode = 'symbol', -- show only symbol annotations

    maxwidth = 50,
    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization.
    -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
      -- Source 显示提示来源
      vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
      return vim_item
    end,
  }),
}

return M
