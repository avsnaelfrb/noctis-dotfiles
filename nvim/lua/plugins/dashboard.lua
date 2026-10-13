return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				vertical_center = true,
				header = {
					"",
					" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"",
				},
				center = {
					{
						icon = "󰈞  ",
						desc = "Find File",
						key = "f",
						action = function()
							require("snacks").picker.files()
						end,
					},
					{
						icon = "󰈢  ",
						desc = "Recent Files",
						key = "r",
						action = function()
							require("snacks").picker.recent()
						end,
					},
					{
						icon = "󰈬  ",
						desc = "Grep",
						key = "g",
						action = function()
							require("snacks").picker.grep()
						end,
					},
					{
						icon = "󰒓  ",
						desc = "Edit Nvim Config",
						key = "c",
						action = function()
							vim.cmd.edit(vim.fn.expand("$MYVIMRC"))
						end,
					},
					{
						icon = "󰈔  ",
						desc = "New File",
						key = "n",
						action = "enew",
					},
					{
						icon = "󰗼  ",
						desc = "Quit Nvim",
						key = "q",
						action = "qa",
					},
				},
			},
		})
	end,
}
