require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.lsp"),
	require("plugins.formatting"),
	require("plugins.oil"),
	require("plugins.neo-tree"),
	require("plugins.treesitter"),
	require("plugins.mini"),
	require("plugins.zdiff"),
	require("plugins.lualine"),
	require("plugins.indent_blankline"),
	"rafamadriz/friendly-snippets",
	"rachartier/tiny-cmdline.nvim",
}, {
	change_detection = { notify = false },
	checker = { enabled = false },
})
