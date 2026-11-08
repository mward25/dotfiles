return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			enabled = true,
			input_after_comment = true,
			snippet_engine = "nvim",
		})
	end,
	keys = {
		{ "<leader>gd", "<cmd>Neogen<CR>", { desc = "Generate annotation (Neogen)" } }
	}
}
