-- extra treesitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.hypr = { ---@diagnostic disable-line
  install_info = {
    url = "https://github.com/luckasRanarison/tree-sitter-hypr",
    files = { "src/parser.c" },
    branch = "master",
  },
  filetype = "hypr",
}

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

parser_config.crystal = { ---@diagnostic disable-line
  install_info = {
    url = "https://github.com/keidax/tree-sitter-crystal",
    branch = "main",
    files = { "src/scanner.c", "src/parser.c" },
    generate_requires_npm = true,
    requires_generate_from_grammer = true,
  },
  filetype = "crystal",
}
