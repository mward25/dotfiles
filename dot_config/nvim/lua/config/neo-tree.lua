return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		opts = {
			use_libuv_file_watcher = true,
			follow_current_file = { enabled = true },
			filesystem = {
				-- Leave netrw alone so oil.nvim handles ":e .";
				-- neo-tree stays as the file tree opened with <leader>t.
				hijack_netrw_behavior = "disabled",
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
