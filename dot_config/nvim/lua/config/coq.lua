return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	lazy = false,
	priority = 100,
	dependencies = {
		require("config.lspconfig"),
		require("config.nvim-treesitter"),
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		require("config.nvim-autopairs"),
	},
	init = function()
		-- vim.opt.autocomplete = true
		-- vim.opt.complete = ""
		-- vim.opt.complete = ""
		vim.g.coq_settings = {
			keymap = {
				recommended = true,
				manual_complete = "<c-space>"
			},
			clients = {
				lsp = {
					always_on_top = {}
				}
			}
		}
		-- vim.opt.completetimeout = 8000
		-- local coq = require("coq")
		-- coq.setup()

		
		-- vim.g.coq_settings = {
		-- 	-- auto_start = "shut-up",
		-- 	keymap = {
		-- 		recommended = false,
		-- 	},
		-- 	-- clients = {
		-- 	-- 	lsp = {
		-- 	-- 		resolve_timeout = 20
		-- 	-- 	}
		-- 	-- }
		-- }
		-- vim.o.autocompletetimeout = 30;

		-- == From https://github.com/windwp/nvim-autopairs ==
		local remap = vim.api.nvim_set_keymap
		local npairs = require("nvim-autopairs")

		npairs.setup({ map_bs = false, map_cr = false })

		-- -- these mappings are coq recommended mappings unrelated to nvim-autopairs
		-- remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
		-- remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
		-- remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
		-- remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
		--
		-- -- skip it, if you use another global object
		-- _G.MUtils = {}
		--
		-- MUtils.CR = function()
		-- 	if vim.fn.pumvisible() ~= 0 then
		-- 		if vim.fn.complete_info({ "selected" }).selected ~= -1 then
		-- 			return npairs.esc("<c-y>")
		-- 		else
		-- 			return npairs.esc("<c-e>") .. npairs.autopairs_cr()
		-- 		end
		-- 	else
		-- 		return npairs.autopairs_cr()
		-- 	end
		-- end
		-- remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })
		--
		-- MUtils.BS = function()
		-- 	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
		-- 		return npairs.esc("<c-e>") .. npairs.autopairs_bs()
		-- 	else
		-- 		return npairs.autopairs_bs()
		-- 	end
		-- end
		-- remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
	end,
	config = function ()
		require('config.lsp.config').setup()
	end
	-- End == From https://github.com/windwp/nvim-autopairs ==
	-- config = function()
	-- 	local coq = require("coq")
	-- 	vim.lsp.config("qmlls", coq.lsp_ensure_capabilities({ cmd = { "qmlls6" } }))
	-- end,
}
