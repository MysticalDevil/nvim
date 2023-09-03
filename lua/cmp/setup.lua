local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local luasnip = require("luasnip")

local util = require("cmp.util")

-- local has_word_before = function()
--   local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local mapping = {
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

local opts = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = mapping,
  sources = cmp.config.sources({
    { name = "luasnip", group_index = 1 },
    {
      name = "nvim_lsp",
      entry_filter = function(entry, ctx)
        local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
        if kind == "Snippet" and ctx.prev_context.filetype == "java" then
          return false
        end
        return true
      end,
    },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "conjure" },
  }),

  formatting = util.formatting,
}

cmp.setup(opts)

---@diagnostic disable-next-line
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
---@diagnostic disable-next-line
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

---@diagnostic disable-next-line
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})

require("cmp.luasnip")
