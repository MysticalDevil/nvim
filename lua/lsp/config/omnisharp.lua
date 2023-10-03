local lsp_util = require("lspconfig.util")
local util = require("lsp.util")
local opts = util.default_configs()

-- Enables support for reading code style, naming convention and analyzer
-- settings from .editorconfig.
opts.enable_editorconfig_support = true

-- If true, MSBuild project system will only load projects for files that
-- were opened in the editor. This setting is useful for big C# codebases
-- and allows for faster initialization of code navigation features only
-- for projects that are relevant to code that is being edited. With this
-- setting enabled OmniSharp may load fewer projects and may thus display
-- incomplete reference lists for symbols.
opts.enable_ms_build_load_projects_on_demand = false

-- Enables support for roslyn analyzers, code fixes and rulesets.
opts.enable_roslyn_analyzers = false

-- Specifies whether 'using' directives should be grouped and sorted during
-- document formatting.
opts.organize_imports_on_format = false

-- Enables support for showing unimported types and unimported extension
-- methods in completion lists. When committed, the appropriate using
-- directive will be added at the top of the current file. This option can
-- have a negative impact on initial completion responsiveness,
-- particularly for the first few completion sessions after opening a
-- solution.
opts.enable_import_completion = false

-- Specifies whether to include preview versions of the .NET SDK when
-- determining which version to use for project loading.
opts.sdk_include_prereleases = true

-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
-- true
opts.analyze_open_documents_only = false

opts.inlay_hints = {
  enable_for_parameters = true,
  for_literal_parameters = true,
  for_indexer_parameters = true,
  for_object_creation_parameters = true,
  for_other_parameters = true,
  enable_for_types = true,
  for_implicit_variable_types = true,
  for_lambda_parameter_types = true,
  for_implicit_object_creation = true,
  suppress_for_parameters_that_differ_only_by_suffix = false,
  suppress_for_parameters_that_match_method_intent = false,
  suppress_for_parameters_that_match_argument_name = false,
}

opts.filetypes = { "cs", "vb" }

opts.root_pattern = lsp_util.root_pattern(".sln") or lsp_util.root_pattern(".csproj")

return util.set_on_setup(opts)
