local util = require("devil.lsp.util")

local function clangd_help()
  local result = vim.system({ "clangd", "--help" }, { text = true }):wait()
  if result.code ~= 0 then
    return ""
  end

  return ("%s\n%s"):format(result.stdout or "", result.stderr or "")
end

local function clangd_has_flag(help, flag)
  return help:find(flag, 1, true) ~= nil
end

local function build_clangd_cmd()
  local help = clangd_help()
  local cmd = {
    "clangd",
    "--pch-storage=memory",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm",
  }

  if clangd_has_flag(help, "--experimental-modules-support") then
    table.insert(cmd, "--experimental-modules-support")
  end

  --if clangd_has_flag(help, "--function-arg-placeholders") then
  --table.insert(cmd, "--function-arg-placeholders=1")
  --end
end

---@type vim.lsp.Config
return vim.tbl_deep_extend("force", util.default_configs(), {
  filetypes = {
    "c",
    "cc",
    "cpp",
    "cuda",
    "objc",
    "objcpp",
    "cppm",
    "ixx",
    "mpp",
  },
  settings = {
    clangd = {
      InlayHints = {
        BlockEnd = false,
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
        TypeNameLimit = 24,
      },
      CompileFlags = {
        Add = { "-Wall", "" },
        Compiler = "clang++",
      },
    },
  },
  cmd = build_clangd_cmd(),
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  single_file_support = true,
})
