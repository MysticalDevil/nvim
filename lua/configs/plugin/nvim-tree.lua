local uConfig = require("configs.core.uConfig")
local uTree = uConfig.nvimTree

if uTree == nil or not uTree.enable then
  return
end

local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("nvim-tree not found")
  return
end

keymap("n", uTree.toggle, ":NvimTreeToggle<CR>")

-- 列表操作快捷键
local list_keys = { -- 打开文件或文件夹
  {
    key = uTree.edit,
    action = "edit",
  },
  -- {
  --    key = uTree.system_open,
  --    action = 'system_open'
  -- },
  { -- v 分屏打开文件
    key = uTree.vsplit,
    action = "vsplit",
  },
  { -- h 分屏打开文件
    key = uTree.split,
    action = "split",
  },
  { -- gitignore
    key = uTree.toggle_git_ignored,
    action = "toggle_git_ignored",
  },
  { -- Hide (dotfiles)
    key = uTree.toggle_dotfiles,
    action = "toggle_dotfiles",
  },
  {
    key = uTree.toggle_custom,
    action = "toggle_custom",
  },
  {
    key = uTree.refresh,
    action = "refresh",
  },
  { -- 文件操作
    key = uTree.create,
    action = "create",
  },
  {
    key = uTree.remove,
    action = "remove",
  },
  {
    key = uTree.copy,
    action = "copy",
  },
  {
    key = uTree.cut,
    action = "cut",
  },
  {
    key = uTree.paste,
    action = "paste",
  },
  {
    key = uTree.copy_name,
    action = "copy_name",
  },
  {
    key = uTree.copy_path,
    action = "copy_path",
  },
  {
    key = uTree.copy_absolute_path,
    action = "copy_absolute_path",
  },
  {
    key = uTree.toggle_file_info,
    action = "toggle_file_info",
  },
  {
    key = uTree.tabnew,
    action = "tabnew",
  },
  { -- 进入下一级
    key = uTree.cd,
    action = "cd",
  },
  { -- 进入上一级
    key = uTree.dir_up,
    action = "dir_ip",
  },
}

local opts = {
  open_on_setup = true,
  -- 完全禁止内置netrw
  disable_netrw = true,
  -- 不显示 git 状态图标
  git = {
    enable = true,
    ignore = true,
  },
  --  project plugin 需要这样设置
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  -- 不隐藏 dotfile，隐藏 node_modules, target 文件夹
  filters = {
    dotfiles = true,
    custom = {
      "node_modules",
      "target",
    },
  },
  view = {
    -- 宽度
    width = 50,
    side = "left",
    -- 隐藏根目录
    hide_root_folder = false,
    -- 自定义列表中的快捷键
    mappings = {
      -- 只用内置快捷键
      custom_only = false,
      list = list_keys,
    },
    -- 不显示行数
    number = false,
    relativenumber = false,
    -- 显示图标
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭
      quit_on_open = true,
    },
  },
  system_open = {
    cmd = "xdg-open",
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
    },
  },
}

nvim_tree.setup(opts)
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
