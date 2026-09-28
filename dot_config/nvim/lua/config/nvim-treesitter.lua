local sitting_langs=require("config.sitting_langs")
return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		nvim_treesitter = require("nvim-treesitter")
		nvim_treesitter.setup {
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath('data') .. '/site'
		}
		nvim_treesitter.install (
			sitting_langs
		)
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
}
