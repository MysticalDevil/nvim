local status, lspsage = pcall(require, "lspsaga")
if not status then
  vim.notify("lspsaga.nvim not found", "error")
  return
end

local opts = {
  ui = {
    -- currently only round theme
    theme = "round",
    -- this option only work in neovim 0.9
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = "solid",
    winblend = 0,
    expand = " ",
    collapse = " ",
    preview = " ",
    code_action = " ",
    diagnostic = " ",
    incoming = " ",
    outgoing = " ",
    kind = {},
  },
  symbol_in_winbar = {
    enable = false,
    separator = " ",
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
}

lspsage.setup(opts)
