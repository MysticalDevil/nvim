local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_extend("keep", util.default_configs(), {
  settings = {
    zls = {
      enable_snippets = true,
      enable_argument_placeholders = true,
      enable_ast_check_diagnostics = true,
      enable_build_on_save = true,
      enable_autofix = false,
      semantic_tokens = "full",
      enable_inlay_hints = true,
      inlay_hints_show_variable_type_hints = true,
      inlay_hints_show_parameter_name = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
      warn_style = false,
      highlight_global_var_declarations = false,
      dangerous_comptime_experiments_do_not_enable = false,
      skip_std_references = false,
      prefer_ast_check_as_child_process = true,
      record_session = false,
      record_session_path = nil,
      replay_session_path = nil,
      builtin_path = nil,
      zig_lib_path = nil,
      zig_exe_path = nil,
      build_runner_path = nil,
      global_cache_path = nil,
      build_runner_global_cache_path = nil,
      completions_with_replace = true,
    },
  },
  single_file_support = true,
})
