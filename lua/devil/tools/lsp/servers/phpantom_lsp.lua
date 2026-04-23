return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpantom_lsp" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
}
