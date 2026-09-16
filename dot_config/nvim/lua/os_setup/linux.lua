local M = {}

function M.open_browser_search(word)
	vim.fn.jobstart({ "firefox", "--search", "What is " .. word }, { detach = true })
end

return M
