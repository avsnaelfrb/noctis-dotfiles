return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indent = {
			char = "┊",
			highlight = "IblIndent",
		},
		whitespace = {
			highlight = "IblIndent",
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			highlight = "IblScope",
		},
		exclude = {
			filetypes = {
				"help",
				"lazy",
				"mason",
				"notify",
				"oil",
				"TelescopePrompt",
			},
		},
	},
}
