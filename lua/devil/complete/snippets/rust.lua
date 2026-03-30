local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local text = ls.text_node

return {
  snippet("iflet", {
    text({ "if let " }),
    insert(1, "Some(value)"),
    text({ " = " }),
    insert(2, "expr"),
    text({ " {", "    " }),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("match", {
    text({ "match " }),
    insert(1, "expr"),
    text({ " {", "    " }),
    insert(2, "pattern => todo!(),"),
    text({ "", "}" }),
  }),
  snippet("testmod", {
    text({ "#[cfg(test)]", "mod tests {", "    use super::*;", "", "    #[test]", "    fn " }),
    insert(1, "works"),
    text({ "() {", "        " }),
    insert(0),
    text({ "", "    }", "}" }),
  }),
  snippet("derive", {
    text("#[derive("),
    insert(1, "Debug, Clone"),
    text(")]"),
  }),
  snippet("impl", {
    text({ "impl " }),
    insert(1, "Type"),
    text({ " {", "    " }),
    insert(0),
    text({ "", "}" }),
  }),
}
