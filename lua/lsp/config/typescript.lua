local status, typescript = pcall(require, "typescript")
if not status then
  vim.notify("Typescript not found", "error")
  return
end

local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
    common.keyAttach(bufnr)

    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

    --[[
        :TypescriptOrganizeImports
        :TypescriptRenameFile
        :TypescriptAddMissingImports
        :TypescriptRemoveUnused
        :TypescriptFixAll
        :TypescriptGoToSourceDefinition
    ]]

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymap("n", "gs", ":TypescriptOrganizeImports<CR>", bufopts)
    keymap("n", "gR", ":TypescriptRenameFile<CR>", bufopts)
    keymap("n", "gi", ":TypescriptAddMissingImports<CR>", bufopts)
    keymap("n", "gu", ":TypescriptRemoveUnused<CR>", bufopts)
    keymap("n", "gf", ":TypescriptFixAll<CR>", bufopts)
    keymap("n", "gD", ":TypescriptGoToSourceDefinition<CR>", bufopts)
  end,
}
return {
  on_setup = function(_)
    typescript.setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = opts,
    })
  end,
}
