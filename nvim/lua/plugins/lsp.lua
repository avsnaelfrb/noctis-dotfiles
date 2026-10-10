local servers = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"vue_ls",
	"jsonls",
	"yamlls",
	"just",
}

return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			PATH = "prepend",
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = servers,
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"b0o/SchemaStore.nvim",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- Hybrid mode untuk file .vue: vue_ls menangani template/CSS, sedangkan
			-- ts_ls menangani blok <script> dan harus memuat @vue/typescript-plugin
			-- agar tsserver paham bahasa Vue (vue_ls meneruskan request tsserver
			-- ke client ts_ls pada buffer yang sama).
			vim.lsp.config("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.stdpath("data")
								.. "/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin",
							languages = { "vue" },
						},
					},
				},
			})

			vim.lsp.enable(servers)

			local map = vim.keymap.set
			map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
			map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
			map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
			map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show references" })
			map("n", "<leader>gh", vim.lsp.buf.hover, { desc = "Show hover documentation" })
			map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
		end,
	},
}
