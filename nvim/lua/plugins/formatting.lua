local function has_config(root, names)
	for _, name in ipairs(names) do
		if vim.uv.fs_stat(root .. "/" .. name) then
			return true
		end
	end
	return false
end

local function project_formatters(names, fallback)
	return function(bufnr)
		local root = vim.fs.root(bufnr, names)
		return root and has_config(root, names) and { "eslint_d", "prettierd" } or fallback
	end
end

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local javascript = project_formatters(
			{ "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" },
			{ "prettierd" }
		)
		local eslint = project_formatters(
			{ "eslint.config.js", "eslint.config.mjs", ".eslintrc", ".eslintrc.json" },
			{ "prettierd" }
		)

		require("conform").setup({
			format_on_save = { timeout_ms = 8000, lsp_format = "fallback" },
			formatters_by_ft = {
				lua = { "stylua" },
				-- Ruff: urutkan import dulu, baru format.
				python = { "ruff_organize_imports", "ruff_format" },
				javascript = javascript,
				javascriptreact = javascript,
				typescript = eslint,
				typescriptreact = eslint,
				vue = { "prettierd" },
				graphql = { "prettierd" },
				go = { "goimports" },
				json = { "prettierd" },
				sh = { "shfmt" },
				sql = { "sql_formatter" },
			},
			formatters = {
				sql_formatter = { prepend_args = { "--language", "postgresql" } },
			},
		})

		-- Format manual kapan saja (sama seperti format saat save).
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format buffer" })
	end,
}
