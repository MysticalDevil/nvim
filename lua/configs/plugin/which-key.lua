local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("which-key not found", "error")
  return
end

local opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

which_key.setup(opts)

which_key.register({
  ["<leader>w"] = { ":w<CR>", "Save file" },
  ["<leader>q"] = { ":q<CR>", "Quit editor" },
  ["<leader>f"] = { "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format file use LSP" },
  ["<leader>ca"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "LSP code action" },
  ["<leader>"] = {
    w = {
      name = "+save",
      a = { ":wa<CR>", "Save all file" },
      q = { ":wq<CR>", "Save file and quit editor" },
    },
    q = {
      name = "+quit",
      q = { ":qa!<CR>", "Safe force quit" },
      a = { ":wqa<CR>", "Save all file and quit editor" },
    },
    b = {
      name = "+bufferline",
      h = { ":BufferLineCloseLeft<CR>", "Close left bufferline" },
      l = { ":BufferLineCloseRight<CR>", "Close right bufferline" },
      o = { ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", "Close other bufferlines" },
      p = { ":BufferLinePickClose<CR>", "Close picked bufferline" },
    },
    -- t = {
    --   name = "+toggleterm",
    --   a = {},
    --   b = {},
    --   c = {},
    -- },
    x = {
      name = "+trouble",
      x = { "<CMD>TroubleToggle<CR>", "Open trouble toggle panel" },
      w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Open workspace diagnostics" },
      d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Open document diagnostics" },
      q = { "<CMD>TroubleToggle quickfix<CR>", "Open trouble quickfix" },
      l = { "<CMD>TroubleToggle loclist<CR>", "Open trouble loclist" },
      r = { "<CMD>TroubleToggle lsp_references<CR>", "Open LSP references" },
    },
  },
  s = {
    name = "+split",
    v = { ":vsp<CR>", "Split window vertically" },
    h = { ":sp<CR>", "Split window horizontally" },
    c = { "<C-w>c", "Close split window" },
    o = { "<C-w>o", "Close others split window" },
    [","] = { ":vertical resize -10<CR>", "Reduce vertical window size" },
    ["."] = { ":vertical resize +10<CR>", "Increase vertical window size" },
    j = { ":horizontal resize -5<CR>", "Reduce horizontal window size" },
    k = { ":horizontal resize +5<CR>", "Increase horizontal window size" },
    ["="] = { "<C-w>=", "Make split windows equal in size" },
  },
  t = {
    name = "+tab",
    s = { "<CMD>tab split<CR>", "Split window use tab" },
    h = { "<CMD>tabprev<CR>", "Switch to previous tab" },
    l = { "<CMD>tabnext<CR>", "Switch to next tab" },
    j = { "<CMD>tabfirst<CR>", "Switch to first tab" },
    k = { "<CMD>tablast<CR>", "Switch to last tab" },
    c = { "<CMD>tabclose<CR>", "Close tab" },
  },
  Z = { ":foldopen<CR>", "Open code block toggle" },
  zz = { ":foldclose<CR>", "Close code block toggle" },
  g = {
    name = "+LSP",
    d = { "", "Go to definition" },
    r = { "", "Go to references" },
    h = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Hover function definition" },
    p = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Open float diagnostics" },
    j = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
    k = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
    s = { "<CMD>TypescriptOrganizeImports<CR>", "Typescript: Organize imports" },
    R = { "<CMD>TypescriptRenameFile<CR>", "Typescript: Rename file" },
    i = { "<CMD>TypescriptAddMissingImports<CR>", "Typescript: Add missing imports" },
    u = { "<CMD>TypescriptRemoveUnused<CR>", "Typescript: Remove unused imports" },
    f = { "<CMD>TypescriptFixAll", "Typescript: Fix all problems" },
    D = { "<CMD>TypescriptGoToSourceDefinition<CR>", "Typescript: Go to source defination" },
  },
})
