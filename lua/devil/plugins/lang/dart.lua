return {
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require("devil.plugins.configs.flutter-tools")
    end,
  },
}
