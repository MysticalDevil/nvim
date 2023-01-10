local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("nvim-treesitter not found")
  return
end

require("nvim-treesitter.install").prefer_git = true

local opts = {
  sync_install = false,
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  -- ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "markdown" },
  -- ensure_installed = "maintained",

  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang, bufnr) -- Disable in larg C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  -- 启用代码缩进模块
  indent = {
    enable = true,
  },
  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    -- disable { 'jsx', 'cpp' }, list of languages you wang to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, bollean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
    colors = {
      "#85ca60",
      "#ee6985",
      "#d6a760",
      "#7794f4",
      "#b38bf5",
      "#7cc7fe",
    }, -- table of hex strings
    -- termcolors = { } -- table of color name strings
  },
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- http://github.com/windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_Definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use than capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- weather to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

treesitter.setup(opts)

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不折叠
vim.opt.foldlevel = 99
