local function clangd_help()
  if vim.g.devil_clangd_help_cache ~= nil then
    return vim.g.devil_clangd_help_cache
  end

  if vim.fn.executable("clangd") ~= 1 then
    vim.g.devil_clangd_help_cache = ""
    return ""
  end

  local ok, result = pcall(function()
    return vim.system({ "clangd", "--help" }, { text = true }):wait(800)
  end)
  if not ok or not result or result.code ~= 0 then
    vim.g.devil_clangd_help_cache = ""
    return ""
  end

  vim.g.devil_clangd_help_cache = ("%s\n%s"):format(result.stdout or "", result.stderr or "")
  return vim.g.devil_clangd_help_cache
end

local function clangd_has_flag(help, flag)
  return help:find(flag, 1, true) ~= nil
end

local function find_query_drivers_from_path()
  local candidates = {
    "riscv32-esp-elf-gcc",
    "riscv32-esp-elf-g++",
    "xtensa-esp32-elf-gcc",
    "xtensa-esp32-elf-g++",
  }

  local paths, seen = {}, {}
  for _, bin in ipairs(candidates) do
    local p = vim.fn.exepath(bin)
    if p and p ~= "" and not seen[p] then
      seen[p] = true
      table.insert(paths, p)
    end
  end
  return paths
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

  if clangd_has_flag(help, "--query-driver") then
    local drivers = find_query_drivers_from_path()
    if #drivers > 0 then
      table.insert(cmd, "--query-driver=" .. table.concat(drivers, ","))
    end
  end

  --if clangd_has_flag(help, "--function-arg-placeholders") then
  --table.insert(cmd, "--function-arg-placeholders=1")
  --end
  return cmd
end

---@type vim.lsp.Config
return {
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
        Add = { "-Wall" },
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
}
