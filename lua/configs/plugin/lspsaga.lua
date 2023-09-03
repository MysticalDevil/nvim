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
    code_action = "󰌵 ",
    diagnostic = "󰃤 ",
    incoming = "󰏷 ",
    outgoing = "󰏻 ",
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
  diagnostic = {
    on_insert = true,
    on_insert_follow = false,
    insert_winblend = 0,
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    max_width = 0.7,
    max_height = 0.6,
    max_show_width = 0.9,
    max_show_height = 0.6,
    text_hl_follow = true,
    border_follow = true,
    extend_relatedInformation = false,
    keys = {
      exec_action = "o",
      quit = "q",
      go_action = "g",
      expand_or_jump = "<CR>",
      quit_in_show = { "q", "<ESC>" },
    },
  },
  implement = {
    enable = true,
    sign = true,
    lang = {},
    virtual_text = true,
    priority = 100,
  },
}

lspsage.setup(opts)
