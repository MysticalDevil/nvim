local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local luasnip = require("luasnip")

local config = require("configs.core.uConfig")

-- local has_word_before = function()
--   local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local mapping = {
  -- 出现补全
  [config.keys.cmp_complete] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  -- 取消
  [config.keys.cmp_abort] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),

  -- 确认
  -- Accept surrently selected item. If none slected, `select` first item
  -- Set `select` to `fasle` to only confirm explicitly slected items
  [config.keys.cmp_confirm] = cmp.mapping.confirm({
    select = true,
    behavior = cmp.ConfirmBehavior.Replace,
  }),
  -- 如果窗口太多可以滚动
  [config.keys.cmp_scroll_doc_up] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  [config.keys.cmp_scroll_doc_down] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

  -- 上一个
  [config.keys.cmp_select_prev_item] = cmp.mapping.select_prev_item(),
  -- 下一个
  [config.keys.cmp_select_next_item] = cmp.mapping.select_next_item(),
}

cmp.setup({
  -- 制定 snippet 引擎 luasnip
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  -- 快捷键
  mapping = mapping,
  -- 来源
  sources = cmp.config.sources({
    {
      name = "luasnip",
      group_index = 1,
    },
    {
      name = "nvim_lsp",
      group_index = 1,
    },
    {
      name = "nvim_lsp_signature_help",
      group_index = 1,
    },
    {
      name = "buffer",
      group_index = 2,
    },
    {
      name = "path",
      group_index = 2,
    },
    {
      name = "crates",
      group_index = 1,
    },
  }),

  -- 使用 lspkind-nvim 显示类型图标
  formatting = require("cmp.lspkind").formatting,
})

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { {
    name = "buffer",
  } },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ {
    name = "buffer",
  } }, { {
    name = "cmdline",
  } }),
})

cmp.setup.filetype({ "markdown", "help" }, {
  sources = { {
    name = "luasnip",
  }, {
    name = "buffer",
  }, {
    name = "path",
  } },
})

require("cmp.luasnip")
