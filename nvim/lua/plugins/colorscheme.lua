return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = false,
			float = { transparent = false },
			no_bold = true,
			no_italic = true,
			auto_integrations = true,
			custom_highlights = function(colors)
				return {
					CursorLine = { bg = colors.surface0 },
					LineNr = { fg = colors.overlay1 },
					CursorLineNr = { fg = colors.yellow, style = { "bold" } },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
