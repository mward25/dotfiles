return {
	setup = function()
		local lsps = require('config.lsp.lsps')
		-- local coq = require('coq')

		vim.lsp.config("qmlls", { cmd = { "qmlls6" } })

		-- for key,val in ipairs(lsps) do
		-- 	print("key:", key)
		-- 	print("val:", val)
		-- 	vim.lsp.config(val, coq.lsp_ensure_capabilities())
		-- end
		-- vim.lsp.config("laravel_lsp", {
		-- 	cmd = { "laravel-lsp" },
		-- 	filetypes = { "php", "blade" },
		-- 	root_dir = function(bufnr, on_dir)
		-- 		local root = vim.fs.root(bufnr, "artisan")
		--
		-- 		if root then
		-- 			on_dir(root)
		-- 		end
		-- 	end,
		-- })
		require('config.lsp.enable').setup()
	end
}
