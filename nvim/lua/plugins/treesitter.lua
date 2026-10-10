return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local languages = {
			"bash", "css", "diff", "go", "gomod", "gowork", "gosum", "graphql", "html",
			"javascript", "jsdoc", "json", "json5", "lua", "luadoc", "luap", "markdown",
			"markdown_inline", "query", "tsx", "typescript", "vim", "vimdoc", "yaml", "python",
			"vue",
		}
		local treesitter = require("nvim-treesitter")
		treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
		treesitter.install(languages)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
