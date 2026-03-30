local gitsigns_keys = {
  {
    "]c",
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        require("gitsigns").nav_hunk("next")
      end)
      return "<Ignore>"
    end,
    desc = "Jump to next hunk",
    expr = true,
  },
  {
    "[c",
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        require("gitsigns").nav_hunk("prev")
      end)
      return "<Ignore>"
    end,
    desc = "Jump to prev hunk",
    expr = true,
  },
  {
    "<leader>rh",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset hunk",
  },
  {
    "<leader>ph",
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview hunk",
  },
  {
    "<leader>gb",
    function()
      require("gitsigns").blame_line()
    end,
    desc = "Blame line",
  },
  {
    "<leader>td",
    function()
      require("gitsigns").preview_hunk_inline()
    end,
    desc = "Toggle deleted",
  },
  {
    "<leader>tl",
    function()
      require("gitsigns").toggle_numhl()
      require("gitsigns").toggle_linehl()
    end,
    desc = "Toggle line highlight",
  },
  {
    "<leader>tw",
    function()
      require("gitsigns").toggle_word_diff()
    end,
    desc = "Toggle word diff",
  },
}

return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = "BufReadPre",
    keys = gitsigns_keys,
    opts = {
      signs = {
        add = { text = "A|" },
        change = { text = "M|" },
        delete = { text = "D_" },
        topdelete = { text = "D‾" },
        changedelete = { text = "D~" },
        untracked = { text = "U|" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
  },
}
