local util = require("devil.lsp.util")
local opts = util.default_configs()

local lsp_util = require("lspconfig.util")

opts.filetypes = { "cs", "vb" }

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

opts.root_dir = function(fname)
  return lsp_util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json")(fname)
    or lsp_util.find_git_ancestor(fname)
end

return util.set_on_setup(opts)
