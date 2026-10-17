return {
	setup = function()
		-- :HarperToggle — load harper_ls for the current buffer, or stop it if already attached.
		-- harper_ls is kept out of vim.lsp.enable() so it only runs on demand.
		vim.api.nvim_create_user_command("HarperToggle", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "harper_ls" })

			if #clients == 0 then
				local config = vim.lsp.config["harper_ls"]
				if not config then
					vim.notify("harper_ls config not found (is nvim-lspconfig installed?)", vim.log.levels.WARN)
					return
				end
				vim.lsp.start(config, {
					bufnr = bufnr,
					reuse_client = config.reuse_client,
					_root_markers = config.root_markers,
				})
				vim.notify("harper_ls started for this buffer")
			else
				for _, client in ipairs(clients) do
					vim.lsp.buf_detach_client(bufnr, client.id)
					if vim.tbl_count(client.attached_buffers) == 0 then
						client:stop()
					end
				end
				vim.notify("harper_ls stopped for this buffer")
			end
		end, { desc = "Toggle harper_ls for the current buffer" })
	end
}
