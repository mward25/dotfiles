require("config.lazy")

vim.cmd.colorscheme "catppuccin-macchiato"

-- LSP Config
vim.lsp.enable({
	'clangd'
	})
vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, { desc = "Vim Lsp Code Actions" })

local space = " "
vim.opt.listchars:append {
	tab = "——",
	multispace=space,
	lead=space,
	trail=space,
	nbsp=space
}
vim.opt.list = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

-- Telescope setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>',      builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Completion Setup
--vim.keymap.set('i', '<C-space>', function() vim.lsp.completion.get() end )
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})


-- require("cmp_git").setup()
	-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	-- cmp.setup.cmdline({ '/', '?' }, {
		-- mapping = cmp.mapping.preset.cmdline(),
		-- sources = {
			-- { name = 'buffer' }
		-- }
	-- })

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	-- cmp.setup.cmdline(':', {
	-- 	mapping = cmp.mapping.preset.cmdline(),
	-- 	sources = cmp.config.sources({
	-- 		{ name = 'path' }
	-- 	}, {
	-- 		{ name = 'cmdline' }
	-- 	}),
	-- 	matching = { disallow_symbol_nonprefix_matching = false }
	-- })

	-- -- Set up lspconfig.
	-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
	-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
	-- 	capabilities = capabilities
	-- }
--vim.g.complete = ".,w,b,u,i,"

-- set listchars=tab:⎼\ ,trail:·,extends:>
