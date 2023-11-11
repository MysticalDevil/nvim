local status, luasnip = pcall(require, "luasnip")
if not status then
  return
end

local types = require("luasnip.util.types")

-- custom snippets
require("luasnip.loaders.from_lua").load({
  paths = ("%s/lua/devil/complete/snippets/lua"):format(vim.fn.stdpath("config")),
})
require("luasnip.loaders.from_vscode").load({
  paths = ("%s/lua/devil/complete/snippets/vscode"):format(vim.fn.stdpath("config")),
})

-- https://github.com/rafamadriz/friendly-snippets/
vim.tbl_map(function(type)
  require("luasnip.loaders.from_" .. type).lazy_load()
end, { "vscode", "snipmate", "lua" })

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

local filetype_extend = require("luasnip").filetype_extend
filetype_extend("typescript", { "tsdoc", "vue" })
filetype_extend("javascript", { "jsdoc", "vue" })
filetype_extend("lua", { "luadoc" })
filetype_extend("python", { "pydoc" })
filetype_extend("rust", { "rustdoc" })
filetype_extend("cs", { "csharpdoc" })
filetype_extend("java", { "javadoc" })
filetype_extend("c", { "cdoc" })
filetype_extend("cpp", { "cppdoc" })
filetype_extend("php", { "phpdoc" })
filetype_extend("kotlin", { "kdoc" })
filetype_extend("ruby", { "rdoc" })
filetype_extend("sh", { "shelldoc" })
filetype_extend("dart", { "flutter" })

-- Keybindings

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
