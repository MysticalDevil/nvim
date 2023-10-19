-- npm install --legacy-peer-deps && npm run compile
---@diagnostic disable-next-line
require("dap-vscode-js").setup({
  -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  node_path = "node",
  -- Path to vscode-js-debug installation.
  debugger_path = ("%s/mason/packages/js-debug-adapter"):format(vim.fn.stdpath("data")),
  -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  -- debugger_cmd = { "js-debug-adapter" },
  -- which adapters to register in nvim-dap
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },

    {
      name = "Edge: localhost:3000",
      type = "pwa-msedge",
      request = "launch",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}/src",
    },

    {
      name = "Chrome: localhost:3000",
      type = "pwa-chrome",
      request = "launch",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}/src",
    },
    {
      type = "chrome",
      request = "launch",
      name = "Next: Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
    },
    {
      type = "node",
      request = "launch",
      name = "Next: Node",
      outputCapture = "std",
      program = "./node_modules/next/dist/bin/next",
      args = "['dev']",
    },
  }
end
