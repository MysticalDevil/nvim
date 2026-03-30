local status, cmp = pcall(require, "cmp")
local notify = require("devil.shared.notify")
if not status then
  notify.error("nvim-cmp not found")
  return
end

local luasnip = require("luasnip")

local util = require("devil.complete.util")

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.setup({
  formatting = util.formatting,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
      winhighlight = "Normal:CmpDoc",
    },
  },
  mapping = util.mapping,
  sources = cmp.config.sources({
    { name = "lazydev", group_index = 0 },
    { name = "luasnip", max_item_count = 10 },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer", keywords = 3 },
    { name = "path" },
    { name = "calc" },
    { name = "treesitter" },
    { name = "crates" },
  }),
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      util.under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
  }, {
    { name = "buffer" },
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})
