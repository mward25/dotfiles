return {
	"nvim-telescope/telescope.nvim",
	priority = 1000,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"BurntSushi/ripgrep",
		"sharkdp/fd",
		"nvim-tree/nvim-web-devicons",
	},
}
