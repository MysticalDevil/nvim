local lsp_util = require("lspconfig.util")
local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "php" }

opts.init_options = {
  -- Extensions
  ["language_server_php_cs_fixer.enabled"] = true,
  ["language_server_phpstan.enabled"] = true,
  ["language_server_psalm.enabled"] = false,
  ["php_code_sniffer.enabled"] = false,
  ["phpunit.enabled"] = false,
  ["prophecy.enabled"] = false,
  ["symfony.enabled"] = false,
  -- Language server worse reflextion extension
  ["language_server_worse_reflection.inlay_hints.enable"] = true,
  ["language_server_worse_reflection.inlay_hints.types"] = true,
  ["language_server_worse_reflection.inlay_hints.params"] = true,
}

opts.root_dir = function(fname)
  return lsp_util.root_pattern("composer.json")(fname) or lsp_util.find_git_ancestor(fname)
end

return util.set_on_setup(opts)
