return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		config = {
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = true,
			follow_current_file = { enabled = true },
			filesystem = {
				window = {
					mappings = {
						["y"] = "yank_path",
					},
				},
				commands = {
					yank_path = function(state)
						-- copy path of current node to unnamed register
						vim.fn.setreg('"', state.tree:get_node().path)
					end,
				},
			},
		},
		lazy = false, -- neo-tree will lazily load itself
	},
}
