-- extra treesitter
parser_config.fsharp = { ---@diagnostic disable-line
  install_info = {
    url = "https://github.com/Nsidorenco/tree-sitter-fsharp",
    branch = "main",
    files = { "src/scanner.cc", "src/parser.c" },
    generate_requires_npm = true,
    requires_generate_from_grammer = true,
  },
  filetype = "fsharp",
}
