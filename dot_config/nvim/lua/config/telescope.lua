return {
	"nvim-telescope/telescope.nvim",
	priority = 500,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<C-p>", function() require("telescope.builtin").buffers() end, desc = "Telescope find files" },
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Telescope buffers" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope help tags" },
		{ "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Telescope find keymaps" },
	},
}
