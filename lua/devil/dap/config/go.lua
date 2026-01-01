return {
  adapters = {
    go = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    },
  },
  configurations = {
    go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug Test", -- 调试当前测试函数
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    },
  },
}
