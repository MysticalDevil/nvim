local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("nvim-treesitter not found", "error")
  return
end

require("nvim-treesitter.install").prefer_git = true

local languages = {
  "c",
  "cpp",
  "dart",
  "go",
  "haskell",
  "java",
  "javascript",
  "kotlin",
  "lua",
  "python",
  "ruby",
  "rust",
  "typescript",
  "tsx",
  "vim",
  "yaml",
  "zig",
}

local opts = {
  ensure_installed = languages,
  sync_install = false,
  auto_install = true,

  -- enable code highlight module
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(_, bufnr) -- Disable in larg C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
  -- enable incremental selection module
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  -- enable code indent module
  indent = { enable = true },
  -- nvim-treesitter/nvim-tree-docs
  tree_docs = { enable = true },
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- http://github.com/windwp/nvim-ts-autotag
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
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
    enable = true,
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

-- enable Folding module
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
