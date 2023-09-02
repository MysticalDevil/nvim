local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  vim.notify("nvim-autopairs not found", "error")
  return
end

local opts = {
  check_ts = true,
  ts_config = {
    -- lua = { "string" }, -- it will not add a piar on that treesitter node
    -- javascript = { "template_string" },
    -- java = false, -- don't check treesitter on java
    fennel = false,
  },
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
}

-- if vim.o.ft == "clap_input" and vim.o.ft == "guihua" and vim.o.ft == "guihua_rust" then
--   require("cmp").setup.buffer({ completion = { enable = false } })
-- end

autopairs.setup(opts)

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
