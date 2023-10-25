local status, lspsaga = pcall(require, "lspsaga")
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
    border = "rounded",
    -- whether to use nvim-web-devicons
    devicon = true,
    winblend = 0,
    expand = " ",
    collapse = " ",
    preview = " ",
    code_action = "󰌵 ",
    actionfix = " ",
    diagnostic = "󰃤 ",
    incoming = "󰏷 ",
    outgoing = "󰏻 ",
    imp_sign = "󰳛 ",
    lines = { "┗", "┣", "┃", "━", "┏" },
    kind = nil,
  },
  hover = {
    max_width = 0.9,
    max_height = 0.8,
    open_link = "gx",
    open_cmd = "!google-chrome-stable",
  },
  diagnostic = {
    on_insert = false,
    on_insert_follow = false,
    insert_winblend = 0,
    show_source = true,
    show_code_action = true,
    show_layout = "float",
    show_normal_height = 10,
    jump_num_shortcut = true,
    max_width = 0.8,
    max_height = 0.6,
    max_show_width = 0.9,
    max_show_height = 0.6,
    text_hl_follow = true,
    border_follow = true,
    extend_relatedInformation = false,
    diagnostic_only_current = false,
    keys = {
      exec_action = "o",
      quit = "q",
      toggle_or_jump = "<CR>",
      quit_in_show = { "q", "<ESC>" },
    },
  },
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = false,
    only_in_cursor = true,
    max_height = 0.3,
    keys = {
      quit = "q",
      exec = "<CR>",
    },
  },
  lightbulb = {
    enable = true,
    sign = true,
    debounce = 10,
    sign_priority = 40,
    virtual_text = true,
    enable_in_insert = true,
  },
  scroll_preview = {
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  request_timeout = 2000,
  finder = {
    max_height = 0.5,
    left_width = 0.3,
    right_width = 0.5,
    methods = {},
    default = "ref+imp",
    layout = "float",
    silent = false,
    filter = {},
    fname_sub = nil,
    sp_inexist = false,
    sp_global = false,
    ly_botright = false,
    keys = {
      shuttle = "[w",
      toggle_or_open = "o",
      vsplit = "s",
      split = "i",
      tabe = "t",
      tabnew = "r",
      quit = "q",
      close = "<C-c>k",
    },
  },
  definition = {
    width = 0.6,
    height = 0.5,
    keys = {
      edit = "<C-c>o",
      vsplit = "<C-c>v",
      split = "<C-c>i",
      tabe = "<C-c>t",
      tabnew = "<C-c>n",
      quit = "q",
      close = "<C-c>k",
    },
  },
  rename = {
    in_select = true,
    auto_save = false,
    project_max_width = 0.5,
    project_max_height = 0.5,
    keys = {
      quit = "<C-k>",
      exec = "<CR>",
      select = "x",
    },
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
  outline = {
    win_position = "right",
    win_width = 30,
    auto_preview = true,
    detail = true,
    auto_close = true,
    close_after_jump = false,
    layout = "normal",
    max_height = 0.5,
    left_width = 0.3,
    keys = {
      toggle_or_jump = "o",
      quit = "q",
      jump = "e",
    },
  },
  callhierarchy = {
    layout = "float",
    left_width = 0.2,
    keys = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      close = "<C-c>k",
      quit = "q",
      shuttle = "[w",
      toggle_or_req = "u",
    },
  },
  implement = {
    enable = true,
    sign = true,
    lang = {},
    virtual_text = true,
    priority = 100,
  },
  beacon = {
    enabled = true,
    frequency = 7,
  },
  floaterm = {
    height = 0.7,
    width = 0.7,
  },
}

lspsaga.setup(opts)

require("devil.utils").keymap("n", "<A-t>", "<CMD>Lspsaga term_toggle<CR>", { desc = "Float term" })
