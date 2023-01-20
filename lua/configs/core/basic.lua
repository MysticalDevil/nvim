-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 不使用相对行号
vim.wo.number = true
vim.wo.relativenumber = false
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指引列
vim.wo.signcolumn = "yes"
-- 右侧参考线，表示代码建议长度
vim.wo.colorcolumn = "130"
-- 缩进4个空格等于1个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.shofttabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代Tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行自动对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = false
-- 命令行高为2
vim.o.cmdheight = 2
-- 当文件被外部程序修改时自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间1000毫秒
vim.o.timeoutlen = 1000
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示
vim.o.list = true
vim.o.listchars = "space:·"
-- 补全增强
vim.o.wildmenu = true
-- Don't pass message to |ins-completion menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示10行
vim.o.pumheight = 10
-- 永远显示 tabline
vim.o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式显示
vim.o.showmode = false
-- 配置剪切板
vim.opt.clipboard = "unnamedplus"
vim.opt.foldtext = "v:lua.require(utils.simple_fold').simple_fold()"

-- GUI 配置
vim.opt.guifont = { "Fira Code", ":h10" }
