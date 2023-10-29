local cmp = require("cmp")

local status, lspkind = pcall(require, "lspkind")
if not status then
  vim.notify("lspkind.nvim not found", "error")
  return
end

local kind_icons = require("devil.utils").kind_icons
local luasnip = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local M = {}
-- Provide parameter format for cmp.lua
M.formatting = {
  fields = {
    cmp.ItemField.Abbr,
    cmp.ItemField.Kind,
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
        vim_item.abbr = ("%s..."):format(shorten_abbr)
      end
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[API]",
        latex_symbols = "[LaTeX]",
        path = "[Path]",
        emoji = "[Emoji]",
        treesitter = "[TreeSitter]",
        crates = "[Crates]",
        npm = "[NPM]",
        cmdline = "[CMD]",
        git = "[Git]",
        calc = "[Calc]",
        conjure = "[Conjure]",
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
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      -- that way you will only jump inside the snippet region
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
}

M.engine = ""

---@param name string
function M.set_engine(name)
  M.engine = name
end

---@return string
function M.get_engine()
  return M.engine
end

M.under = function(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end

return M
