return {
	"YousefHadder/markdown-plus.nvim",
	ft = "markdown",
	opts = {
		keymaps = { enabled = true },
	},
	config = function(_, opts)
		require("markdown-plus").setup(opts)

		vim.keymap.set("i", "<C-;><CR>", "<Plug>(MarkdownPlusListShiftEnter)", { buffer = true })
		vim.keymap.set("i", "<C-;>h", "<Plug>(MarkdownPlusTableNavLeft)", { buffer = true })
		vim.keymap.set("i", "<C-;>j", "<Plug>(MarkdownPlusTableNavDown)", { buffer = true })
		vim.keymap.set("i", "<C-;>k", "<Plug>(MarkdownPlusTableNavUp)", { buffer = true })
		vim.keymap.set("i", "<C-;>l", "<Plug>(MarkdownPlusTableNavRight)", { buffer = true })
	end,
}
