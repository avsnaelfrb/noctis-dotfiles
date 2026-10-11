return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			enabled = true,
		},
		notifier = {
			enabled = true,
			top_down = false, -- notifikasi baru muncul dari bawah
			timeout = 3000,
			width = { min = 40, max = 0.4 },
		},
		styles = {
			notification = {
				border = "rounded",
				wo = { winblend = 0 },
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Find files: hanya di dalam cwd, tampil nama file saja
		vim.keymap.set("n", "<leader>sf", function()
			Snacks.picker.files({
				cwd = vim.fn.getcwd(),
				formatters = { file = { filename_only = true } },
			})
		end, { silent = true, desc = "Find files" })

		-- Live grep
		vim.keymap.set("n", "<leader>sg", function()
			Snacks.picker.grep()
		end, { silent = true, desc = "Live grep" })

		-- Buffers
		vim.keymap.set("n", "<leader>sb", function()
			Snacks.picker.buffers()
		end, { silent = true, desc = "Buffers" })

		-- Help
		vim.keymap.set("n", "<leader>sh", function()
			Snacks.picker.help()
		end, { silent = true, desc = "Help" })

		-- Diagnostics
		vim.keymap.set("n", "<leader>sd", function()
			Snacks.picker.diagnostics()
		end, { silent = true, desc = "Diagnostics" })

		-- Git hunks
		vim.keymap.set("n", "<leader>su", function()
			Snacks.picker.git_diff()
		end, { silent = true, desc = "Git hunks" })

		-- Recent files (riwayat)
		vim.keymap.set("n", "<leader>sc", function()
			Snacks.picker.recent()
		end, { silent = true, desc = "Recent files" })

		-- Keymaps
		vim.keymap.set("n", "<leader>sk", function()
			Snacks.picker.keymaps()
		end, { silent = true, desc = "Keymaps" })

		-- Resume picker terakhir
		vim.keymap.set("n", "<leader><space>", function()
			Snacks.picker.resume()
		end, { silent = true, desc = "Resume picker" })
	end,
}
