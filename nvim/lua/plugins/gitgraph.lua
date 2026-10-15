return {
	"isakbm/gitgraph.nvim",
	keys = {
		{
			"<leader>gl",
			function()
				-- draw() menggambar ke window aktif, jadi buka float dulu
				local width = math.floor(vim.o.columns * 0.9)
				local height = math.floor(vim.o.lines * 0.85)
				local buf = vim.api.nvim_create_buf(false, true)
				-- bufhidden=wipe: buffer sementara ini langsung dibuang saat
				-- digantikan buffer GitGraph oleh draw()
				vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
				vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					width = width,
					height = height,
					row = math.floor((vim.o.lines - height) / 2),
					col = math.floor((vim.o.columns - width) / 2),
					border = "rounded",
					title = " Git Graph ",
					title_pos = "center",
				})
				require("gitgraph").draw({}, { all = true, max_count = 5000 })
			end,
			desc = "GitGraph - Draw in float",
		},
	},
	opts = {},
}
