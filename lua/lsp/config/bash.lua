local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
    require("nvim-navic").attach(client, bufnr)
  end,
  -- require("coq").lsp_ensure_capabilities(),
  settings = {
    cmd = { "bash-language-server", "start" },
    cmd_env = {
      GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
    },
    filetype = {
      "sh",
      "zsh",
      "bash",
    },
  },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
