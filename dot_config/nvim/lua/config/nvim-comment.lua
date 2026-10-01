return {
	"mward25/Comment.nvim",
	-- dir = "/home/miles/projects/Comment.nvim",
	dependencies  = {
		"JoosepAlviste/nvim-ts-context-commentstring"
	},
	config = function()
		require("Comment").setup {
			pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
		}
		-- ts_context_commentstring = require('ts_context_commentstring').setup()
		-- -- ts_context_commentstring.setup {
		-- --   enable_autocmd = false,
		-- -- }
		-- require('nvim_comment').setup {
		-- 	hook = function()
		-- 		require('ts_context_commentstring').update_commentstring()
		-- 	end,
		-- }
	end
}
