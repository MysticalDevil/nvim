local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local text = ls.text_node

return {
  snippet("ife", {
    text({ "if err != nil {", "\treturn " }),
    insert(1, "err"),
    text({ "", "}" }),
  }),
  snippet("ctx", {
    text("ctx := context."),
    insert(1, "Background"),
    text("()"),
  }),
  snippet("tt", {
    text({ "tests := []struct {", "\tname string", "}{", '\t{name: "' }),
    insert(1, "case"),
    text({ '"},', "}", "", "for _, tt := range tests {", "\tt.Run(tt.name, func(t *testing.T) {", "\t\t" }),
    insert(0),
    text({ "", "\t})", "}" }),
  }),
  snippet("subt", {
    text({ 't.Run("' }),
    insert(1, "case"),
    text({ '", func(t *testing.T) {', "\t" }),
    insert(0),
    text({ "", "})" }),
  }),
  snippet("bench", {
    text({ "func Benchmark" }),
    insert(1, "Name"),
    text({ "(b *testing.B) {", "\tfor i := 0; i < b.N; i++ {", "\t\t" }),
    insert(0),
    text({ "", "\t}", "}" }),
  }),
}
