local status, jdtls = pcall(require, "jdtls")
if not status then
  vim.notify("nvim-jdtls not found", "error")
  return
end

local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "settings.gradle", "build.gradle" })
if root_dir == "" then
  root_dir = vim.fn.getcwd()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
extendedClientCapabilities.document_formatting = false

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = ("%s/java/workspace/%s"):format(vim.fn.stdpath("cache"), project_name)

local bundles = {}
bundles = {
  vim.fn.expand(
    "~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), "\n")
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

    "-configuration",
    vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_mac"),

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
            path = "/usr/lib/jvm/openjdk-11/",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/openjdk-17/",
          },
          {
            name = "JavaSE-19",
            path = "/usr/lib/jvm/openjdk-bin-19/",
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
    extendedClientCapabilities = extendedClientCapabilities,
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
    if vim.fn.has("nvim-0.10") == 1 then
      vim.lsp.inlay_hint(bufnr, true)
    end
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    require("jdtls.setup").add_commands()
    require("lsp.util").default_on_attach(client, bufnr)
  end,
  filetypes = { "java" },
}

jdtls.start_or_attach(config)
