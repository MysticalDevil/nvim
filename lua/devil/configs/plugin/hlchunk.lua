local status, hlchunk = pcall(require, "hlchunk")
if not status then
  vim.notify("hlchunk.nvim not found", "error")
  return
end

local opts = {
  chunk = {
    enable = true,
    notify = true,
    use_treesitter = true,
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "┌",
      left_bottom = "└",
      right_arrow = "─",
    },
    style = {
      { fg = "#00eedd" },
      { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
    },
    textobject = "",
    max_file_size = 1024 * 1024,
    error_sign = true,
  },

  indent = {
    enable = true,
    use_treesitter = false,
    chars = {
      "│",
    },
    style = {
      { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
    },
  },

  line_num = {
    enable = true,
    use_treesitter = false,
    style = "#806d9c",
  },

  blank = {
    enable = true,
    chars = {
      "․",
    },
    style = {
      vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
    },
  },
}

hlchunk.setup(opts)