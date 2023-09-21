local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local commonAutoGroup = augroup("commonAutoGroup", { clear = true })
local indentAutoGroup = augroup("indentAutoGroup", { clear = true })

local lispFiletypes = { "clj", "*.el", "*.fnl", "*.hy", "*.janet", "*.lisp", "*.rkt", "*.scm" }

-- Terminal mode automatically enters insert mode
autocmd("TermOpen", {
  group = commonAutoGroup,
  command = "startinsert",
})

autocmd("BufEnter", {
  group = commonAutoGroup,
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
  desc = "newlines with `o` do not continue comments",
})

autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "commonAutoGroup",
  pattern = lispFiletypes,
  command = "ParinferOn",
  desc = "Auto enable brackets matching for lisp files",
})

autocmd("FileType", {
  group = "indentAutoGroup",
  pattern = { "java", "kotlin", "c", "cpp" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.expandtab = false
  end,
})

-- Function to set V filetype
local function set_v_filetype()
  local filename = vim.api.nvim_buf_get_name(0)
  if vim.fn.fnamemodify(filename, ":e") == "v" then
    vim.api.nvim_buf_set_option(0, "filetype", "v")
  end
end

-- Set filetype on VimEnter before reading any buffers
autocmd("VimEnter", {
  callback = function()
    set_v_filetype()
  end,
})

-- Set filetype in FileType autocmd in case VimEnter is missed
autocmd("FileType", {
  pattern = "*",
  callback = function()
    set_v_filetype()
  end,
})
