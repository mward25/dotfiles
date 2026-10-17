return {
	"amrbashir/nvim-docs-view",
	cmd = "DocsViewToggle",
	opts = {
		position = "right",
		width = 60
	},
	keys = {
		{ '<leader>l', '<cmd>DocsViewUpdate<CR>', desc = "Show docs for current symbol"},
		{ '<leader>L', '<cmd>DocsViewToggle<CR>', desc = "Remove doc view"}
	},
	lazy = true,
}
