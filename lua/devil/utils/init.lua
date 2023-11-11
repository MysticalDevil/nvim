local M = {}

local common = require("devil.utils.common")
M.log = common.log
M.keymap = common.keymap
M.deep_print = common.deep_print
M.kind_icons = common.kind_icons

local lsp_tool = require("devil.utils.lsp_tool")
M.not_proxy_lsp = lsp_tool.not_proxy_lsp
M.async_formatting = lsp_tool.async_formatting
M.get_lsp_info = lsp_tool.get_lsp_info

local command = require("devil.utils.command")
M.start_nrepl = command.start_nrepl
M.stop_nrepl = command.stop_nrepl

return M