local uConfig = require("configs.core.uConfig")
local uTelescope = uConfig.telescope

if uTelescope == nil or not uTelescope.enable then
  return
end

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end

local opts = {
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert, 也可以是 normal
    initial_mode = "insert",
    -- vertival, center, cursor
    layout_strategy = "horizontal",
    -- 窗口内快捷键
    mappings = {
      i = {
        -- 上下移动
        [uTelescope.move_selection_next] = "move_selection_next",
        [uTelescope.move_selection_previous] = "move_selection_previous",
        -- 历史记录
        [uTelescope.cycle_history_next] = "cycle_history_next",
        [uTelescope.cycle_history_prev] = "cycle_history_prev",
        -- 关闭窗口
        [uTelescope.close] = "close",
        -- 预览窗口上下滚动
        [uTelescope.preview_scrolling_up] = "preview_scrolling_up",
        [uTelescope.preview_scrolling_down] = "preview_scrolling_down",
      },
    },
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有：dropdown, cursorm, ivy
      -- theme = 'dropdown',
    },
  },
  extensions = {
    -- 扩展插件配置
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
        initial_mode = "normal",
      }),
    },
  },
}

telescope.setup(opts)

keymap("n", uTelescope.find_files, ":Telescope find_files<CR>")
keymap("n", uTelescope.live_grep, ":Telescope live_grep<CR>")

pcall(telescope.load_extension, "env")
pcall(telescope.load_extension, "ui-select")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
