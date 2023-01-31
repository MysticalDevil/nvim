local status, luasnip = pcall(require, "luasnip")
if not status then
  return
end

local s = luasnip.s --> snippet
local i = luasnip.i --> insert node
local t = luasnip.t --> text node

local d = luasnip.dytnamic_node
local c = luasnip.choice_node
local f = luasnip.function_node
local sn = luasnip.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local exampleSnippet = s(
  "exampleSnippet",
  fmt(
    [[
    local {} = function({})
      {}
    end
    ]],
    {
      i(1, " "),
      c(2, { t("aaa"), t("myArg"), t("3333") }),
      i(3, ""),
    }
  )
)
table.insert(snippets, exampleSnippet)

local pluginConfigSnippet = s(
  "pluginConfig",
  fmt(
    [[
    local status, {} = pcall(require, {})
    if not status then
      vim.notify("{} not found", "error")
      return
    end
    ]],
    {
      i(1),
      i(2, '""'),
      i(3),
    }
  )
)

table.insert(snippets, pluginConfigSnippet)

return snippets, autosnippets
