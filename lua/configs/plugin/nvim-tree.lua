local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("nvim-tree not found", "error")
  return
end

keymap("n", "<A-m>", ":NvimTreeToggle<CR>")

-- 列表操作快捷键
local list_keys = { -- 打开文件或文件夹
  {
    key = { "<CR>", "o", "<2-LeftMouse>" },
    action = "edit",
  },
  { -- v 分屏打开文件
    key = "sv",
    action = "vsplit",
  },
  { -- h 分屏打开文件
    key = "sh",
    action = "split",
  },
  { -- gitignore
    key = "i",
    action = "toggle_git_ignored",
  },
  { -- Hide (dotfiles)
    key = ".",
    action = "toggle_dotfiles",
  },
  {
    key = "u",
    action = "toggle_custom",
  },
  {
    key = "R",
    action = "refresh",
  },
  { -- 文件操作
    key = "a",
    action = "create",
  },
  {
    key = "d",
    action = "remove",
  },
  {
    key = "c",
    action = "copy",
  },
  {
    key = "x",
    action = "cut",
  },
  {
    key = "p",
    action = "paste",
  },
  {
    key = "y",
    action = "copy_name",
  },
  {
    key = "Y",
    action = "copy_path",
  },
  {
    key = "gy",
    action = "copy_absolute_path",
  },
  {
    key = "I",
    action = "toggle_file_info",
  },
  {
    key = "t",
    action = "tabnew",
  },
  { -- 进入下一级
    key = ">",
    action = "cd",
  },
  { -- 进入上一级
    key = "<",
    action = "dir_ip",
  },
}

local opts = {
  open_on_setup = false,
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
