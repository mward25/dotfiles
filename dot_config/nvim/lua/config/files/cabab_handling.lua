local M = {}

local web_filetypes = {
	"blade",
	"html",
	"css",
	"scss",
	"sass",
	"less",
}

-- Treat "-" as part of words (kebab-case / cabab) only in web filetypes,
-- instead of setting iskeyword globally.
function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = web_filetypes,
		callback = function()
			vim.opt_local.iskeyword:append("-")
		end,
		desc = "iskeyword '-' append for web filetypes (kebab-case words)",
	})
end

return M
