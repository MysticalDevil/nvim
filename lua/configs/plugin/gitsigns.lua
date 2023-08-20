local status, gitsigns = pcall(require, "gitsigns")
if not status then
  vim.notify("gitsigns not found", "error")
  return
end

local opts = {
  -- Letter icon. A is add，M is modify， D is delete
  signs = {
    add = { hl = "GitSignsAdd", text = "A|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "M|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "D_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "D‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "D~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  -- show icon
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  -- line number highlight
  numhl = false, -- Toggle with `Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `Gitsigns toggle_linehl`
  word_diff = true, -- Toggle with `Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `LGitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlat' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_with
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "<leader>gj", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })

    map("n", "<leader>gk", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })

    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
    map("n", "<leader>gS", gs.stage_buffer)
    map("n", "<leader>gu", gs.undo_stage_hunk)
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>gR", gs.reset_buffer)
    map("n", "<leader>gp", gs.preview_hunk)
    map("n", "<leader>gb", function()
      gs.blame_line({
        full = true,
      })
    end)
    map("n", "<leader>gd", gs.diffthis)
    map("n", "<leader>gD", function()
      gs.diffthis("~")
    end)
    -- toggle
    map("n", "<leader>gtd", gs.toggle_deleted)
    map("n", "<leader>gtD", gs.toggle_current_line_blame)
    -- Text object
    -- map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

gitsigns.setup(opts)
