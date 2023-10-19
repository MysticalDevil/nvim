local lsp_util = require("lspconfig.util")
local util = require("devil.lsp.util")

local opts = util.default_configs()

local root_file = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.json",
  "eslint.config.js",
}

opts.filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "vue",
  "svelte",
  "astro",
}

opts.settings = {
  codeAction = {
    disableRuleComment = {
      enable = true,
      location = "separateLine",
    },
    showDocumentation = {
      enable = true,
    },
  },
  codeActionOnSave = {
    enable = false,
    mode = "all",
  },
  experimental = {
    useFlatConfig = false,
  },
  format = true,
  nodePath = "",
  onIgnoredFiles = "off",
  packageManager = "npm",
  problems = {
    shortenToSingleLine = false,
  },
  quiet = false,
  rulesCustomizations = {},
  run = "onType",
  useESLintClass = false,
  validate = "on",
  workingDirectory = {
    mode = "location",
  },
}

opts.on_attach = function(client, bufnr)
  util.default_on_attach(client, bufnr)

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    command = "EslintFixAll",
  })
end

opts.root_dir = function(fname)
  root_file = lsp_util.insert_package_json(root_file, "eslintConfig", fname)
  return lsp_util.root_pattern(unpack(root_file))(fname)
end

opts.single_file_support = false

return util.set_on_setup(opts)
