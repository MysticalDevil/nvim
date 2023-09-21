-- Rewrite the filetype of *.v
vim.filetype.add({
  extension = {
    v = "vlang",
    vv = "vlang",
    vsh = "vlang",
  },
})
