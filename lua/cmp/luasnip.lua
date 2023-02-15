local status, ls = pcall(require, "luasnip")
if not status then
  return
end

local types = require("luasnip.util.types")

-- custom snippets
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.stdpath("config") .. "/lua/cmp/snippets/lua",
})
require("luasnip.loaders.from_vscode").load({
  paths = vim.fn.stdpath("config") .. "/lua/cmp/snippets/vscode",
})

-- https://github.com/rafamadriz/friendly-snippets/
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
  history = true,
  update_events = "TextChanged, TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      },
    },
  },
})

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jumpable()
  end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then
    ls.choice_active(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
