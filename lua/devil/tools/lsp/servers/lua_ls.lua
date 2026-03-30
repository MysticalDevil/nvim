---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the langurage server which version of Lua you're using
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = "Auto",
        await = true,
        paramName = "All",
        paramType = true,
        semicolon = "SameLine",
        setType = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
  single_file_support = true,
}
