-- Floating file explorer, centered like mini.pick
local popup_config = function()
	local height = math.floor(0.8 * vim.o.lines)
	local width = math.floor(0.6 * vim.o.columns)

	return {
		position = "float",
		size = {
			width = width,
			height = height,
		},
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
		border = "none", -- borderless like mini.pick
	}
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Open file explorer" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			window = {
				position = "float",
				config = popup_config,
				mappings = {
					["<space>"] = "none",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					visible = true,
					show_hidden_count = true,
				},
			},
			event_handlers = {
				-- Close neo-tree after opening a file
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.ui.renderer").close_all_floating_windows()
					end,
				},
			},
		})
	end,
}
