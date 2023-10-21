local tbl = {
  a = 1,
  b = 3,
}

table.insert(tbl, { c = 2 })

for k, v in pairs(tbl) do
  vim.notify(k, ": ", v)
end
