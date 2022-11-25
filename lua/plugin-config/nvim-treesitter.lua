local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  vim.notify('nvim-treesitter not found')
  return
end

treesitter.setup({
  -- Install language server
  -- :TSInstallInfo 查看命令支持的语言
  ensure_installed = {
    'json',
    'html',
    'css',
    'vim',
    'lua',
    'javascript',
    'markdown',
    'markdown_inline',
    'gitignore',
    'bash',
    'yaml',
    'toml',
    'rust',
    'typescript',
    'tsx',
    'python',
    'go',
    'ruby',
  },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    },
  },
  -- 启用代码缩进模块
  indent = {
    enable = true,
  },
})

-- 开启 Folding 模块
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不折叠
vim.opt.foldlevel = 99
