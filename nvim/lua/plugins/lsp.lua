local servers = {
	"lua_ls",
	"basedpyright",
	"ruff",
	"ts_ls",
	"vue_ls",
	"jsonls",
	"yamlls",
	"just",
	"rust_analyzer",
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

			-- Rust: rustfmt tidak menambah semicolon (bisa mengubah makna tail
			-- expression), jadi pakai quickfix "add `;`" dari rust-analyzer saat
			-- menyimpan. Hanya repair yang dilaporkan compiler yang diterapkan.
			-- shortcut: bergantung teks pesan rust-analyzer "add `;`"; perbarui
			-- bila pesannya berubah di versi baru.
			local function rust_fix_semicolon(bufnr)
				local client = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })[1]
				if not client then
					return
				end
				local diags, targets = {}, {}
				for _, d in ipairs(vim.diagnostic.get(bufnr)) do
					local lsp = d.user_data and d.user_data.lsp
					if lsp then
						diags[#diags + 1] = lsp
						if d.message:find("add `;`") then
							targets[#targets + 1] = lsp.range
						end
					end
				end
				if #targets == 0 then
					return
				end
				for _, range in ipairs(targets) do
					local pending = true
					client:request("textDocument/codeAction", {
						textDocument = vim.lsp.util.make_text_document_params(bufnr),
						range = range,
						context = { diagnostics = diags, only = { "quickfix" } },
					}, function(err, actions)
						if not err then
							for _, a in ipairs(actions or {}) do
								if a.title:find("add `;`") and a.edit then
									vim.lsp.util.apply_workspace_edit(a.edit, client.offset_encoding)
									break
								end
							end
						end
						pending = false
					end, bufnr)
					vim.wait(2000, function()
						return not pending
					end)
				end
			end

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.rs",
				callback = function(ev)
					rust_fix_semicolon(ev.buf)
				end,
			})

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
