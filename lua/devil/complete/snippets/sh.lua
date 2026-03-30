local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local text = ls.text_node

return {
  snippet("strict", {
    text({ "set -euo pipefail" }),
  }),
  snippet("usage", {
    text({ "usage() {", '  cat <<"EOF"', "Usage: " }),
    insert(1, "script.sh [args]"),
    text({ "", "EOF", "}" }),
  }),
  snippet("case", {
    text({ 'case "${1:-}" in', "  " }),
    insert(1, "value"),
    text({ ")", "    " }),
    insert(2),
    text({ "", "    ;;", "  *)", "    " }),
    insert(0),
    text({ "", "    ;;", "esac" }),
  }),
  snippet("trap", {
    text({ "cleanup() {", "  " }),
    insert(1),
    text({ "", "}", "trap cleanup EXIT" }),
  }),
}
