local status, metals = pcall(require, "metals")
if not status then
  vim.notiify("nvim-metals not found", "error")
  return
end

local metals_config = metals.bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  --disabledMode = true,
  --bloopVersion = "1.5.6-253-5faffd8d-SNAPSHOT",
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  enableSemanticHighlighting = false,
  --fallbackScalaVersion = "2.13.10",
  serverVersion = "latest.snapshot",
  --serverVersion = "0.11.2+74-7a6a65a7-SNAPSHOT",
  --serverVersion = "1.0.2-SNAPSHOT",
  --testUserInterface = "Test Explorer",
}

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

---@diagnostic disable-next-line
metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
  if vim.fn.has("nvim-0.10") == 1 then
    vim.lsp.inlay_hint(bufnr)
  end
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
