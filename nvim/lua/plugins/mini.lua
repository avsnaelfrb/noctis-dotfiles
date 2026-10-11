return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup()
		require("mini.align").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.jump").setup()
		require("mini.diff").setup({
			view = {
				-- Tampilkan marker di sign column (default: number column kalau nomor baris aktif)
				style = "sign",
				signs = {
					add = "+",
					change = "~",
					delete = "-",
					top = "",
					bottom = "",
					middle = "",
				},
			},
		})

		require("mini.splitjoin").setup({ mappings = { toggle = "<leader>m" } })
		require("mini.hipatterns").setup({
			highlighters = { hex_color = require("mini.hipatterns").gen_highlighter.hex_color() },
		})
		require("plugins.mini.completions")
	end,
}
