return {
  {
    "nvim-flutter/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      ui = {
        border = "rounded",
        notification_style = "plugin",
      },
      decorations = {
        statusline = {
          app_version = false,
          device = false,
          project_config = false,
        },
      },
      debugger = {
        enabled = false,
        run_via_dap = false,
        exception_breakpoints = {},
        register_configurations = function(_)
          require("dap").configurations.dart = {}
        end,
      },
      flutter_path = nil,
      flutter_lookup_cmd = "mise where flutter",
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = false,
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        notify_errors = false,
        open_cmd = "tabedit",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = false,
          background = false,
          background_color = nil,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        on_attach = require("devil.tools.lsp.util").default_on_attach,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {},
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          enableSdkFormatter = true,
        },
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
      },
    },
  },
}
