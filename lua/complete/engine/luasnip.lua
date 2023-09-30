local status, luasnip = pcall(require, "luasnip")
if not status then
  return
end

local types = require("luasnip.util.types")

-- custom snippets
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.stdpath("config") .. "/lua/complete/snippets/lua",
})
require("luasnip.loaders.from_vscode").load({
  paths = vim.fn.stdpath("config") .. "/lua/complete/snippets/vscode",
})

-- https://github.com/rafamadriz/friendly-snippets/
require("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.set_config({
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
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jumpable()
  end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.choice_active() then
    luasnip.choice_active(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)
