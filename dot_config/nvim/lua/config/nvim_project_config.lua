return {
	'windwp/nvim-projectconfig',
	config = function()
		require('nvim-projectconfig').setup({
			project_dir = "~/.config/projects-config/",
		})
	end,
	lazy = false
}
