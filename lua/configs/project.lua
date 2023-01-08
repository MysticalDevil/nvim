local status, project = pcall(require, 'project_nvim')
if not status then
  vim.notify('project_nvim not found')
end

-- nvim-tree 支持

local opts = {
  detection_methods = { 'pattern' },
  patterns = {
    'README.md',
    'Cargo.toml',
    '.git',
    '_darcs',
    '.hg',
    '.bzr',
    '.svn',
    'Makefile',
    'package.json',
    '.sln',
  },
}

project.setup(opts)

local status, telescope = pcall(require, 'telescope')
if not status then
  vim.notify('telescope not found')
  return
end
pcall(telescope.load_extension, 'projects')
