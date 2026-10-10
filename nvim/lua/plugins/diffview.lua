return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
	},
	keys = {
		{
			"<leader>zd",
			function()
				-- Toggle: buka kalau belum ada, tutup kalau diffview sedang terbuka
				local view = require("diffview.lib").get_current_view()
				vim.cmd(view ~= nil and "DiffviewClose" or "DiffviewOpen")
			end,
			desc = "Toggle diffview (uncommitted)",
		},
		{ "<leader>zh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
					winbar_info = false,
				},
				file_history = {
					layout = "diff2_horizontal",
				},
				file_panel = {
					win_config = { width = 35 },
				},
			},
		})
	end,
}
