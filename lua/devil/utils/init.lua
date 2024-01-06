local M = {}
local merge_tb = vim.tbl_deep_extend

local common = require("devil.utils.common")
local lsp_tool = require("devil.utils.lsp_tool")
local command = require("devil.utils.command")

local temp_tb = merge_tb("force", {}, common or {})
temp_tb = merge_tb("force", temp_tb, lsp_tool or {})
temp_tb = merge_tb("force", temp_tb, command or {})

M = temp_tb or {}

return M
