local status, jdtls = pcall(require, "jdtls")
if not status then
  vim.notify("nvim-jdtls not found", "error")
  return
end

local mason_registry = require("mason-registry")

--------- utils function ----------
---@param version string
---@return table
local function get_jvms(version)
  return { ("openjdk-%s"):format(version), ("java-%s"):format(version) }
end

---@param jvm_version string
---@return string
local function find_jvm_path(jvm_version)
  local jvm_paths = get_jvms(jvm_version)
  for _, path in ipairs(jvm_paths) do
    if vim.fn.executable(("/usr/bin/jvm/%s/bin/java"):format(path)) == 1 then
      return ("/usr/bin/jvm/%s"):format(path)
    end
  end
  return ""
end

local operative_system
if vim.fn.has("linux") then
  operative_system = "linux"
elseif vim.fn.has("win32") then
  operative_system = "win"
elseif vim.fn.has("macunix") then
  operative_system = "mac"
end

--------- configurations ----------

local root_dir =
  require("jdtls.setup").find_root({ ".git", "gradlew", "settings.gradle", "build.gradle", "mvnw", "pom.xml" })

local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()

local capabilities = vim.lsp.protocol.make_client_capabilities()

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = ("%s/java/workspace/%s"):format(vim.fn.stdpath("cache"), project_name)

local java_test_path = mason_registry.get_package("java-test"):get_install_path()
local java_debug_adapter_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
local bundles = {}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(java_debug_adapter_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
)

local config = {
  filetypes = { "java" },
  autostart = true,
  cmd = {
    -- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. jdtls_path .. "/lombok.jar",

    -- 💀
    "-jar",
    vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                           ^^^^^^^^^^^^^^
    -- Must point to the                                                         Change this to
    -- eclipse.jdt.ls installation                                               the actual version, with vim.fn.glob() is not necessary

    -- 💀
    "-configuration",
    jdtls_path .. "/config_" .. operative_system,
    -- ^^^^^^^^^^^^^^^^^^^                  ^^^^^^
    -- Must point to the                    Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation          Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    "-data",
    workspace_dir,
  },
  capabilities = capabilities,
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      import = {
        maven = { enabled = true },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "**/Frontend/**",
          "**/CSV_Aggregator/**",
        },
      },
      maven = { downloadSources = true },
      eclipse = { downloadSources = true },
      autobuild = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        overwrite = false,
        guessMethodArguments = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = find_jvm_path("11"),
          },
          {
            name = "JavaSE-17",
            path = find_jvm_path("17"),
          },
          {
            name = "JavaSE-21",
            path = find_jvm_path("21"),
          },
        },
      },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = { enabled = true },
    },
    codeGeneration = {
      generateComments = true,
      useBlocks = true,
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
    },
    flags = {
      debounce_text_changes = 150,
      allow_incremental_sync = true,
    },
  },
  on_init = function(client)
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end,
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = {
      resolveAdditionalTextEditsSupport = true,
      progressReportProvider = false,
    },
  },
  handlers = {
    -- ["language/status"] = function() end,
    -- ["workspace/diagnostic/refresh"] = function() end,
    -- ["textDocument/codeAction"] = function() end,
    -- ["textDocument/rename"] = function() end,
    -- ["workspace/applyEdit"] = function() end,
    -- ["textDocument/documentHighlight"] = function() end,
  },
  on_attach = function(client, bufnr)
    require("devil.utils").load_mappings("lspconfig", { buffer = bufnr })

    require("devil.lsp.util").set_inlay_hints(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    require("devil.lsp.util").default_on_attach(client, bufnr)
  end,
}

return config
