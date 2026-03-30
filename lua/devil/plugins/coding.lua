local icons = require("devil.shared.icons")

return {
  { "neovim/nvim-lspconfig", priority = 1000, lazy = false },
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  { "stevearc/conform.nvim", event = { "BufReadPost", "BufNewFile" }, cmd = { "ConformInfo" } },
  { "mfussenegger/nvim-lint", event = { "BufReadPost", "BufNewFile" } },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/lua/devil/complete/snippets" },
          })
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "petertriho/cmp-git",
        "ray-x/cmp-treesitter",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      {
        "de",
        function()
          local dap = require("dap")
          local dap_ui = require("dapui")
          dap.close()
          dap.terminate()
          dap.repl.close()
          dap_ui.close()
          dap.clear_breakpoints()
        end,
        desc = "End debugger",
      },
      {
        "dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue debug",
      },
      {
        "dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Set breakpoint",
      },
      {
        "dT",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Clear breakpoint",
      },
      {
        "dj",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "dk",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "dl",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "dh",
        function()
          require("dapui").eval()
        end,
        desc = "Popups dapUI eval",
      },
    },
    dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      require("mason-nvim-dap").setup({ ensure_installed = {}, automatic_installation = true })
      require("devil.tools").setup()
    end,
  },
  { "jbyuki/one-small-step-for-vimkind" },
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "default",
        symbol_map = icons,
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim" },
    opts = function()
      return require("devil.plugins.configs.actions-preview")
    end,
  },
}
