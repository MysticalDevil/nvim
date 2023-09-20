local status, jdtls = pcall(require, "jdtls")
if not status then
  vim.notify("nvim-jdtls not found", "error")
  return
end

local binary = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

local config = {
  cmd = { binary },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

jdtls.start_or_attach(config)
