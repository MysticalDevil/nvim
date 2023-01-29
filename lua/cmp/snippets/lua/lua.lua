local status, ls = pcall(require, "luasnip")
if not status then
  return
end

local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dytnamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

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
