local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("lualine not found")
	return
end

local opts = {
	options = {
		theme = "onedark",
		component_separators = { left = "|", right = "|" },
		-- https://github.com/ryanoasis/powerline-extra-symbols
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	extensions = { "nvim-tree", "toggleterm" },
	sections = {
		lualine_c = {
			"filename",
			{
				"lsp_progress",
				spinner_symbols = { "", "", "", "", "", "" },
			},
		},
		lualine_x = {
			"filesize",
			{
				"fimeformat",
				-- symbols = {
				--   bsd = '', -- f30c
				--   linux = '', -- ebc6
				--   dos = '', -- e70f
				--   mac = '', --e711
				-- }
				symbols = {
					unix = "LF",
					dos = "CRLF",
					mac = "CR",
				},
			},
			"encoding",
			"filetype",
		},
	},
}

lualine.setup(opts)
