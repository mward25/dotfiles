return {
  "dhruvasagar/vim-table-mode",

	init = function()
		vim.g.table_mode_map_prefix = '<Leader>f'
		vim.opt.foldlevelstart = 99
	end,
}
