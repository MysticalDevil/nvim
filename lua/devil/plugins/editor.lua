local flash_keys = {
  {
    "S",
    function()
      require("flash").treesitter()
    end,
    desc = "Flash Treesitter",
    mode = { "n", "x", "o" },
  },
  {
    "R",
    function()
      require("flash").treesitter_search()
    end,
    desc = "Treesitter Search",
    mode = { "x", "o" },
  },
  {
    "r",
    function()
      require("flash").remote()
    end,
    desc = "Remote Flash",
    mode = "o",
  },
  {
    "<c-s>",
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
    mode = "c",
  },
}

local function flash_opts()
  return require("devil.plugins.configs.flash")
end

return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local augend = require("dial.augend")
      local config = require("dial.config")

      config.augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
        },
        typescript = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.new({ elements = { "let", "const" } }),
        },
        visual = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = flash_keys,
    opts = flash_opts,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {},
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Incremental Rename",
        expr = true,
      },
    },
    opts = {},
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      {
        "<leader>nf",
        function()
          require("neogen").generate({ type = "any" })
        end,
        desc = "Use neogen to generate",
      },
    },
    opts = {
      enabled = true,
      input_after_comment = true,
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    event = "QuickFixCmdPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "y", "<Plug>(YankyYank)", desc = "Yank text", mode = { "n", "x" } },
      { "p", "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", desc = "Put yanked text after selection", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", desc = "Put yanked text before selection", mode = { "n", "x" } },
      { "]y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "[y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
      {
        "<leader>yp",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History",
      },
    },
    opts = {},
  },
}
