local M = {}

function M.open_browser_search(word)
	vim.fn.jobstart({ "cmd.exe", "/c", "start", "https://www.google.com/search?q=" .. vim.fn.escape(word, " ") }, { detach = true })
end

return M
