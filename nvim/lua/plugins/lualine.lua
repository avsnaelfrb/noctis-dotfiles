return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ok, harpoon_mark = pcall(require, "harpoon.mark")
		local function harpoon_indicator()
			if not ok then
				return ""
			end
			local name = vim.fn.expand("%:p")
			if name == "" then
				return ""
			end
			local index = harpoon_mark.get_index_of(name)
			return index and ("󱡅 " .. index) or ""
		end

		require("lualine").setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", harpoon_indicator },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
