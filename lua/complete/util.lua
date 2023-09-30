local cmp = require("cmp")

local status, lspkind = pcall(require, "lspkind")
if not status then
  vim.notify("lspkind.nvim not found", "error")
  return
end

local kind_icons = {
  Text = "󰉿",
  Unit = "󰑭",
  Value = "󰎠",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  Reference = "󰈇",
  Folder = "󰉋",
  File = "󰈙 ",
  Module = " ",
  Class = "󰌗 ",
  Method = "󰆧 ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = "󰕘",
  Interface = "󰕘",
  Function = "󰊕 ",
  Variable = "󰆧 ",
  Constant = "󰏿 ",
  EnumMember = " ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
}

local M = {}
-- Provide parameter format for cmp.lua
M.formatting = {
  fields = {
    cmp.ItemField.Kind,
    cmp.ItemField.Abbr,
    cmp.ItemField.Menu,
  },
  format = lspkind.cmp_format({
    mode = "symbol_text",

    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    ellipsis_char = "...",

    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization.
    -- (See [#30](https://github.com/onsails/lspkind.nvim/pull/30))
    before = function(entry, vim_item)
      local shorten_abbr = string.sub(vim_item.abbr, 1, 30)
      if shorten_abbr ~= vim_item.abbr then
        vim_item.abbr = shorten_abbr .. "..."
      end
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[API]",
        -- latex_symbols = "[LaTeX]",
        cmp_tabnine = "[Tabnine]",
        path = "[Path]",
        -- emoji = "[Emoji]",
      })[entry.source.name]
      return vim_item
    end,
  }),
}

M.mapping = {
  -- completion appears
  ["<A-.>"] = cmp.mapping(cmp.mapping.completion, { "i", "c" }),
  -- cancel
  ["<A-,>"] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),

  -- confirm
  -- Accept surrently selected item. If none slected, `select` first item
  -- Set `select` to `fasle` to only confirm explicitly slected items
  ["<CR>"] = cmp.mapping.confirm({
    select = true,
    behavior = cmp.ConfirmBehavior.Replace,
  }),
  -- can scroll if too many items
  ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

  -- previous
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  -- next
  ["<C-j>"] = cmp.mapping.select_next_item(),
}

return M
