local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("dashboard not found")
end

db.custom_footer = {
	"",
	"",
	"https://github.com/MysticalDevil",
}

db.custom_center = {
	{
		icon = "  ",
		desc = "Projects                 ",
		action = "Telescope projects",
	},
	{
		icon = "ﮦ  ",
		desc = "Recently files           ",
		action = "Telescope oldfiles",
	},
	{
		icon = "  ",
		desc = "Edit keybindings         ",
		action = "edit ~/.config/nvim/lua/keybindings.lua",
	},
	{
		icon = "  ",
		desc = "Edit Project             ",
		action = "edit ~/.local/share/nvim/project_nvim/project_history",
	},
}

db.custom_header = {
	[[]],
	[[]],
	[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
	[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
	[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
	[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
	[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
	[[]],
	[[]],
}

db.hide_tabline = true
db.hide_statusline = false
