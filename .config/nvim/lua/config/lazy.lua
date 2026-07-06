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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		require("config.telescope"),

		require("config.catppuccin"),
		require("config.lualine"),
		require("config.render-markdown"),
		require("config.trouble"),
		require("config.arborist"),
		require("config.neogen"),
		require("config.d2-vim"),

		{ "tpope/vim-sleuth", priority = 1000 },
		{ "nvim-tree/nvim-tree.lua", priority = 1000 },
		{ "neovim/nvim-lspconfig", priority = 1000 },
		{ "tpope/vim-commentary", name = "vim-commentary", priority = 1000 },
		{ "tpope/vim-surround", name = "vim-surround", priority = 1000 },
		{ "luisjure/csound-vim", name = "csound-vim", priority = 1000 },
		require("config.auto-session"),
		require("config.neogit"),
		require("config.vim-table-mode"),
		require("config.snacks"),
		require("config.codecompanion"),
		require("config.cmp"),
	},
	install = {},
	checker = { enabled = true },
})
