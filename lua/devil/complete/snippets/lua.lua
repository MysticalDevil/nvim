local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local text = ls.text_node

return {
  snippet("mod", {
    text({ "local M = {}", "", "" }),
    insert(1),
    text({ "", "", "return M" }),
  }),
  snippet("req", {
    text("local "),
    insert(1, "mod"),
    text(' = require("'),
    insert(2, "devil.module"),
    text('")'),
  }),
  snippet("plug", {
    text({ "{", '  "' }),
    insert(1, "author/plugin.nvim"),
    text('",'),
    text({ "", "  " }),
    insert(0),
    text({ "", "}," }),
  }),
  snippet("cmd", {
    text('vim.api.nvim_create_user_command("'),
    insert(1, "CommandName"),
    text({ '", function()', "  " }),
    insert(2),
    text({ "", 'end, { desc = "' }),
    insert(3, "Describe command"),
    text('" })'),
  }),
  snippet("au", {
    text('vim.api.nvim_create_autocmd("'),
    insert(1, "BufWritePost"),
    text({ '", {', "  callback = function(args)", "    " }),
    insert(2),
    text({ "", "  end,", "})" }),
  }),
  snippet("map", {
    text('vim.keymap.set("'),
    insert(1, "n"),
    text('", "'),
    insert(2, "<leader>x"),
    text('", '),
    insert(3, "function() end"),
    text(', { desc = "'),
    insert(0, "Describe mapping"),
    text('" })'),
  }),
  snippet("fn", {
    text("local function "),
    insert(1, "name"),
    text("("),
    insert(2),
    text({ ")", "  " }),
    insert(0),
    text({ "", "end" }),
  }),
}
