return {
	"https://github.com/arborist-ts/arborist.nvim",
	lazy = false,
	config = function()
		require("arborist").setup({
			update_cadence = "daily",
			install_popular = true,
		})
	end,
}
