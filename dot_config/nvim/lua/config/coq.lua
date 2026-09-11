return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	lazy = false,
	priority = 1000,
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
	},
	init = function()
		vim.g.coq_settings = {
			-- auto_start = "shut-up",
			keymap = {
				-- recommended = false,
				-- manual_complete = "<c-n>",
			},
		}
	end,
	-- config = function()
	-- 	local coq = require("coq")
	-- 	vim.lsp.config("qmlls", coq.lsp_ensure_capabilities({ cmd = { "qmlls6" } }))
	-- end,
}
