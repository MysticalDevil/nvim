local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local luasnip = require("luasnip")

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
    {
      name = "luasnip",
      group_index = 1,
    },
    {
      name = "nvim_lsp",
      group_index = 1,
    },
    -- {
    --   name = "nvim_lsp_signature_help",
    --   group_index = 1,
    -- },
    {
      name = "buffer",
      group_index = 2,
    },
    {
      name = "path",
      group_index = 2,
    },
    {
      name = "calc",
      group_index = 3,
    },
    {
      name = "crates",
      group_index = 1,
    },
    {
      name = "cmdline",
      group_index = 2,
    },
  }),

  -- use lspkind-nvim to show type icon
  formatting = require("cmp.lspkind").formatting,
}

cmp.setup(opts)

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.filetype({ "markdown", "help" }, {
  sources = cmp.config.sources({
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }, {
    { name = "path" },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

require("cmp.luasnip")
