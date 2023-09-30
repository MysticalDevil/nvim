local util = require("lsp.util")

local opts = util.default_configs()

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

return util.on_setup(opts, require("complete.setup").engine)
