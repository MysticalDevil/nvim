local hl = require("devil.shared.highlight")

return {
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
    lazy = true,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "BufRead package.json",
    opts = {
      highlights = {
        up_to_date = hl.style({
          fg = { { "Comment", "fg" }, { "NonText", "fg" }, { "LineNr", "fg" } },
        }),
        outdated = hl.style({
          fg = { { "DiagnosticWarn", "fg" }, { "WarningMsg", "fg" }, { "Number", "fg" } },
        }),
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
      package_manager = "yarn",
    },
  },
}
