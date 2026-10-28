-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable netrw before any plugins load (required by nvim-tree)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		require("config.coq"),
		require("config.lspconfig"),
		require("config.telescope"),

		require("config.catppuccin"),
		require("config.lualine"),
		require("config.render-markdown"),
		require("config.trouble"),
		require("config.mdkite"),
		--require("config.arborist"),
		require("config.neogen"),
		require("config.d2-vim"),

		require("config.guess-indent"),
		--{ "nvim-tree/nvim-tree.lua", priority = 1000 },
		-- require("config.neo-tree"),
		require("config.chadtree"),
		require("config.oil"),
		-- require("config.yazi"),

		-- { "shoukoo/commentary.nvim", config = true },
		{ "luisjure/csound-vim", name = "csound-vim" },
		require("config.smart-paste"),
		require("config.diffs"),
		require("config.auto-session"),
		require("config.neogit"),
		require("config.vim-table-mode"),
		require("config.markdown-plus"),
		require("config.snacks"),
		--require("config.codecompanion"),
		require("config.lazygit"),
		require("config.nvim-treesitter"),
		require("config.nvim-ts-autotag"),
		require("config.nvim-autopairs"),
		require("config.nvim-surround"),
		require("config.nvim-comment"),
		require("config.nvim_project_config"),
		require("config.mason")
		--require("config.laravel")
		-- require('config.nvim_doc_view')
	},
	install = {},
	checker = { enabled = true },
})
