# 主要插件列表及键位配置

- ## bufferline.nvim

  > [`bufferline`](https://github.com/akinsho/bufferline.nvim)将 buffer 显示为类似 VScode 标签页的样式

  **键位绑定如下**
  `Ctrl + h` 前一个标签页
  `Ctrl + l` 后一个标签页
  `Ctrl + w` 关闭标签页
  `Leader + bh` 关闭左侧标签页
  `Leader + bl` 关闭右侧标签页
  `Leader + bo` 关闭其他标签页
  `Leader + bp` 关闭选定标签页

- ## comment.nvim

  > [`comment`](https://github.com/numToStr/Comment.nvim)高效智能的快速注释插件

  **键位绑定如下**
  `gcc` 行注释
  `gbc` 块注释
  `gc` 行注释(v)
  `gb` 块注释(v)

- ## dashboard.nvim

  > [`dashboard`](https://github.com/glepnir/dashboard-nvim) neovim 的启动页面

- ## fidget.nvim

  > [`fidget`](https://github.com/j-hui/fidget.nvim) nvim-lsp 的独立进度条 ui

- ## gitsigns.nvim

  > [`gitsigns`](https://github.com/lewis6991/gitsigns.nvim) 在 buffer 中集成 git

  **键位绑定如下**
  `Leader-gj` next hunk
  `Leader-gk` prev hunk
  `Leader-gs` stage hunk(n, v)
  `Leader-gS` stage buffer
  `Leader-gu` undo stage hunk
  `Leader-gr` reset hunk(n, v)
  `Leader-gR` reset buffer
  `Leader-gp` preview hunk
  `Leader-gb` blame line
  `Leader-gd` diff
  `Leader-gD` diff this
  `Leader-gtd` toggle deleted
  `Leader-gtD` toffle current line blame
  `ig` select hunk(o, x)

- ## indent-blankline.nvim

  > [`indent-blankline`](https://github.com/lukas-reineke/indent-blankline.nvim) 用于显示缩进的线条，更加直观的确认缩进

- ## lualine.nvim

  > [`lualine`](https://github.com/nvim-lualine/lualine.nvim) 使用 lua 编写的 statusline，显示 neovim 的状态

- ## nvim-autopairs

  > [`nvim-autopairs`](https://github.com/windwp/nvim-autopairs) neovim 自动配对插件，一般用于括号配对，引号配对

- ## nvim-notify

  > [`nvim-notify`](https://github.com/rcarriga/nvim-notify) 一个花哨的、可配值的 neovim 通知管理器

- ## nvim-surround

  > [`nvim-surround`](https://github.com/kylechui/nvim-surround) 轻松添加/更改/删除周围的界定符号对

- ## nvim-tree

  > [`nvim-tree`](https://github.com/nvim-tree/nvim-tree.lua) neovim 的侧边栏目录树

  **键位绑定如下**
  `o/LeftMouseClick/<CR>` 编辑文件
  `sv` v 分屏打开文件
  `sh` h 分屏打开文件
  `i` 折叠/显示隐藏文件
  `.` 折叠/显示dotfile
  `u` 折叠/显示系统文件
  `R` 刷新文件
  `a` 添加文件
  `d` 删除文件
  `c` 复制文件
  `x` 剪切文件
  `p` 粘贴文件
  `y` 复制文件名
  `Y` 复制文件路径
  `gy` 复制相对路径
  `I` 折叠/显示文件信息
  `t` 新建标签
  `]` 进入下级目录
  `[` 返回上级目录

- ## nvim-treesitter

  > [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) Better 代码高亮插件

- ## project.nvim

  > [`project`](https://github.com/ahmedkhalf/project.nvim) 项目管理插件，提供一个 tui 界面来显示最近打开的项目

- ## telescope.nvim

  > [`telescope`](https://github.com/nvim-telescope/telescope.nvim) 列表模糊查找器，类似 VScode 的 Ctrl + Shift + P

  **键位绑定如下**
  `Ctrl-j/k` 在查找窗口向下/上移动
  `Down/Up` 历史记录翻页
  `Ctrl-c` 关闭窗口
  `Ctrl-u/d` 预览窗口上下滚动
  `Ctrl-p` 查找文件
  `Ctrl-f` 查找内容

- ## todo-dcommets.nvim

  > [`todo-comments`](https://github.com/folke/todo-comments.nvim) 突出显示、列出和搜索项目中的 TODO

- ## toggleterm.nvim

  > [`toggleterm`](https://github.com/akinsho/toggleterm.nvim) 帮助轻松管理多个终端窗口的插件

- ## zen-mode.nvim

  > [`zen-mode`](https://github.com/folke/zen-mode.nvim) neovim 的无干扰编码
  **键位绑定如下**
  `Leader-a` 开启 zen mode
