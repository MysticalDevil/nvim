-- utf8 encoding
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- keep 8 lines around the cursor when `hjkl` moves
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- do not use relative line numbers
vim.wo.number = true
vim.wo.relativenumber = false
-- hightlight the row
vim.wo.cursorline = true
-- show left icon guide bar
vim.wo.signcolumn = "yes"
-- the reference line on the right indicates the recommended length of the code
vim.wo.colorcolumn = "130"
-- indentation, 2 spaces equals a tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> and << the length of the move
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- spaces instead of tabs
vim.o.expandtab = true
vim.bo.expandtab = true
-- new line is automatically aligned with current line
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- searches are case insensitive unless uppercase is included
vim.o.ignorecase = true
vim.o.smartcase = true
-- search result highlight
vim.o.hlsearch = true
-- search while typing
vim.o.incsearch = false
-- the command line height is 2
vim.o.cmdheight = 2
-- automatically load when the file is modified by an external program
vim.o.autoread = true
vim.bo.autoread = true
-- no wrapping
vim.wo.wrap = false
-- when the cursor is at the beginning and end of the line, use <Left><Right> to jump the next line
vim.o.whichwrap = "<,>,[,]"
-- allows to hide modified buffers
vim.o.hidden = true
-- mouse support
vim.o.mouse = "a"
-- disable creation of backup files
vim.o.backup = false
vim.o.writebackup = false
vim.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- set the shortcut key combo time to not exceed 1000ms
vim.o.timeoutlen = 1000
-- `split window` appeares from above and to the right
vim.o.splitbelow = true
vim.o.splitright = true
-- autocomplete but not autoselect
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- style
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- show invisible characters
vim.opt.list = true
-- vim.opt.listchars:append("space:·")
-- vim.opt.listchars:append("eol:↴")
-- completion enhancement
vim.o.wildmenu = true
-- don't pass message to |ins-completion menu|
vim.o.shortmess = ("%sc"):format(vim.o.shortmess)
-- completion can display up to 10 lines
vim.o.pumheight = 10
-- always show tabline
vim.o.showtabline = 2
-- plug-ins that use the enhanced status bar no longer require vim's mode display
vim.o.showmode = false
-- configure clipboard
vim.opt.clipboard = "unnamedplus"

-- code folding configuration
-- default is not folded
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- default color mode
vim.o.termguicolors = true

-- improve startup time for neovim
vim.loader.enable()
