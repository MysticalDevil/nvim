local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local choice = ls.choice_node
local text = ls.text_node

return {
  snippet("ts", {
    text({ "```" }),
    choice(1, { text("ts"), text("js") }),
    text({ "", "" }),
    insert(0),
    text({ "", "```" }),
  }),
  snippet("js", {
    text({ "```" }),
    choice(1, { text("js"), text("ts") }),
    text({ "", "" }),
    insert(0),
    text({ "", "```" }),
  }),
  snippet("json", {
    text({ "```json", "" }),
    insert(0),
    text({ "", "```" }),
  }),
}
