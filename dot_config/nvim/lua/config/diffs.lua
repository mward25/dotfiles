return {
	"https://forge.barrettruth.com/barrettruth/diffs.nvim.git",
	init = function()
		vim.g.diffs = {
			enabled = true,
			conflict = {
				keymaps = {
				  ours = '<leader>co',
				  theirs = '<leader>ct',
				  both = '<leader>ca',
				  none = '<leader>c0',
				  next = ']x',
				  prev = '[x',
				},
			},
			integrations = {
				difftastic = true,
			}
		}
	end
}
