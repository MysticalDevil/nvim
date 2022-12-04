local uConfig = require('uConfig')
local uTelescope = uConfig.telescope

if uTelescope == nil or not uTelescope.enable then
  return
end

local status, telescope = pcall(require, 'telescope')
if not status then
  vim.notify('telescope not found')
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert, 也可以是 normal
    initial_mode = 'insert',
    -- vertival, center, cursor
    layout_strategy = 'horizontal',
    -- 窗口内快捷键
    mappings = {
      i = {
        -- 上下移动
        [uTelescope.move_selection_next] = 'move_selection_next',
        [uTelescope.move_selection_previous] = 'move_selection_previous',
        -- 历史记录
        [uTelescope.cycle_history_next] = 'cycle_history_next',
        [uTelescope.cycle_history_prev] = 'cycle_history_prev',
        -- 关闭窗口
        [uTelescope.close] = 'close',
        -- 预览窗口上下滚动
        [uTelescope.preview_scrolling_up] = 'preview_scrolling_up',
        [uTelescope.preview_scrolling_down] = 'preview_scrolling_down',
      }
    }
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有：dropdown, cursorm, ivy
      -- theme = 'dropdown',
    }
  },
  extensions = {
    -- 扩展插件配置
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({
        -- even more opts
        initial_mode = 'normal'
      })
    }
  },
})

keymap('n', uTelescope.find_files, ':Telescope find_files<CR>')
keymap('n', uTelescope.live_grep, ':Telescope live_grep<CR>')

pcall(telescope.load_extension, 'env')
pcall(telescope.load_extension, 'ui-select')
