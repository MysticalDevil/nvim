local ls = require("luasnip")

local snippet = ls.snippet
local insert = ls.insert_node
local choice = ls.choice_node
local text = ls.text_node

local function fenced(trigger, languages)
  return snippet(trigger, {
    text({ "```" }),
    choice(1, languages),
    text({ "", "" }),
    insert(0),
    text({ "", "```" }),
  })
end

return {
  fenced("ts", { text("ts"), text("js") }),
  fenced("js", { text("js"), text("ts") }),
  fenced("json", { text("json"), text("jsonc") }),
  fenced("bash", { text("bash"), text("sh") }),
  fenced("lua", { text("lua") }),
  fenced("yaml", { text("yaml") }),
  fenced("toml", { text("toml") }),
  fenced("go", { text("go") }),
  fenced("rust", { text("rust") }),
  fenced("cpp", { text("cpp"), text("c") }),
  snippet("note", {
    text({ "> [!NOTE]", "> " }),
    insert(0),
  }),
  snippet("warn", {
    text({ "> [!WARNING]", "> " }),
    insert(0),
  }),
  snippet("todo", {
    text({ "## TODO", "", "- " }),
    insert(0),
  }),
  snippet("steps", {
    text({ "1. " }),
    insert(1, "first step"),
    text({ "", "2. " }),
    insert(2, "second step"),
    text({ "", "3. " }),
    insert(0, "third step"),
  }),
  snippet("api", {
    text({ "## API", "", "- Request: `" }),
    insert(1, "GET /path"),
    text({ "`", "- Response: " }),
    insert(0),
  }),
}
