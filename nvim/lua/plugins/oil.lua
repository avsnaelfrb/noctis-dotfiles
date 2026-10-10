return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = { { "<leader>E", "<cmd>Oil<cr>", desc = "Open oil file editor" } },
	dependencies = { "refractalize/oil-git-status.nvim" },
	config = function()
		require("oil").setup({
			win_options = { signcolumn = "yes:2" },
			view_options = { show_hidden = true },
			watch_for_changes = true,
		})
		require("oil-git-status").setup({ show_ignored = false })
	end,
}
