# neovim-config

MysticalDevil 的 Neovim 的自定义配置

## 基础配置

- **模式**
  normal_mode = 'n'

  insert_mode = 'i'

  visual_mode = 'v'

  visual_block_mode = 'x'

  term_mode = 't'

  command_mode = 'c'

  无括号均为 normal 模式

- **基础键位**
  `<leader>` 键为逗号

  `Ctrl-j/k` 命令选取界面的下/上一个(c)

  `Leader-w` 保存

  `Leader-wq` 保存并退出

  `Leader-wa` 保存全部

  `Leader-qa` 保存全部并退出

  `Leader-qq` 全部退出

  `Leader-q` 退出当前

  `$` 跳转到行尾不带空格(v, n)

- **快速跳转**
  `Ctrl-j/k` 向下/上滚动 5 行(n, v)

  `Ctrl-d/u` 向下/上滚动 10 行(n, v)

- **分屏**
  `sv` 水平分屏

  `sh` 垂直分屏

  `sc` 关闭分屏

  `so` 关闭其他分屏

- **窗口跳转**
  `Alt-h/j/k/l` 窗口之间跳转

- **比例控制**
  `s,/.` 减少/增加宽度

  `sj/k` 减少/增加高度

  `s=` 相等宽高

- **标签**
  `ts` 分割标签(类似分屏，但是会在左上角显示标签号)

  `th/l/j/k` 前后首尾标签

  `tc` 关闭标签

- **TreeSitter**
  `Z` 打开代码块

  `zz` 关闭代码块

  `Leader-f` 格式化代码

- **Terminal**
  TODO

## 插件通用快捷键

- **LSP**
  `Leader-rn` 变量重构

  `Leader-ca` Code Action

  `Leader-f` 格式化

  `gd` 查看定义(go to definition)

  `gh` 光标处查看定义(hover)

  `gr` 参考(reference)

  `gp` Open flow

  `gj` Goto next

  `gk` Goto prev

- **Typescript**
  `gs` TS Originize

  `gR` 重命名文件

  `gi` 添加缺失的 import

- **DAP | vimspector**
  `Leader-dd` 开始调试

  `Leader-de` 结束调试

  `Leader-dc` 继续调试

  `Leader-dt` 设置断点

  `Leader-dT` 清除断点

  `Leader-dj` 步过

  `Leader-dk` 步出

  `Leader-dl` 步入

  `Laeder-dh` Pop ups

## 主要插件

详见[Plugin.md](Plugin.md) 和 [Languages.md](Languages.md)
