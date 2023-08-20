local status, project = pcall(require, "project_nvim")
if not status then
  vim.notify("project_nvim not found", "error")
  return
end

local opts = {
  detection_methods = { "pattern" },
  patterns = {
    "README.md",
    "Cargo.toml",
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
    ".sln",
  },
}

project.setup(opts)

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("telescope not found")
  return
end
pcall(telescope.load_extension, "projects")
