local M = {}

-- Custom "refresh" command.
-- Currently just tears down the auto-saved session for this directory and
-- quits Neovim, so the next launch starts clean.
function M.setup()
	vim.api.nvim_create_user_command("Refresh", function()
		vim.cmd("AutoSession delete")
		vim.cmd("q")
	end, { desc = "Delete the current auto-saved session and quit" })
end

return M
