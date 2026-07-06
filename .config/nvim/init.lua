require("config.lazy")

vim.opt.grepprg = "rg --vimgrep"

vim.opt.exrc = true
vim.opt.secure = true

vim.cmd.colorscheme("catppuccin-macchiato")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "=> "

vim.opt.spell = true
vim.opt.spelloptions = "camel"

-- LSP Config
vim.lsp.config("qmlls", { cmd = { "qmlls6" } })

vim.lsp.config("harper_ls", {
	settings = {
		["harper-ls"] = {
			userDictPath = "",
			fileDictPath = "",
			filetypes = {
				"markdown",
				"tex",
				"text",
				"rst", -- reStructuredText
				"asciidoc",
				"org", -- Org mode
				"mail", -- mutt/email
				"gitcommit",
				"html", -- debatable, but prose-heavy
			},
			linters = {
				SpellCheck = false,
				SentenceCapitalization = false,
				SplitWords = false,
			},
		},
	},
})
vim.lsp.enable({
	"clangd",
	"qmlls",
	"harper_ls",
	"rust-analyzer",
	"lua_ls",
	"yaml-language-server",
})
vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { desc = "Vim Lsp Code Actions" })
vim.keymap.set("x", "g.", vim.lsp.buf.code_action, { desc = "Vim Lsp Code Actions (visual)" })
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" })
vim.keymap.set("n", "g]", function()
	vim.diagnostic.goto_next()
end, { desc = "Next LSP diagnostic" })
vim.keymap.set("n", "g[", function()
	vim.diagnostic.goto_prev()
end, { desc = "Prev LSP diagnostic" })
vim.keymap.set("n", "<leader>gd", ":Neogen<CR>", { desc = "Generate annotation (Neogen)" })

vim.opt.tabstop = 4

local space = " "
vim.opt.listchars:append({
	tab = "——",
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
})
vim.opt.list = true

require("nvim-tree").setup({ sync_root_with_cwd = true })

local function nvimtree_sync_cwd()
	require("nvim-tree.api").tree.change_root(vim.fn.getcwd(-1, 0))
end
vim.api.nvim_create_autocmd("TabEnter", { callback = nvimtree_sync_cwd })
vim.api.nvim_create_autocmd("DirChanged", { pattern = "tabpage", callback = nvimtree_sync_cwd })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-S-Tab>", ":tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-w><leader>c", ":tabclose<CR>", { desc = "Close current tab" })

-- Window resize mode
vim.keymap.set("n", "<leader>wr", function()
	local amount = 2
	local msg = "RESIZE (amount=" .. amount .. "): h/l wider/narrower  k/j taller/shorter  q/ESC/Enter to exit"
	vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
	while true do
		local key = vim.fn.getchar()
		local char = type(key) == "number" and vim.fn.nr2char(key) or key
		if char == "h" then
			vim.cmd("vertical resize +" .. amount)
		elseif char == "l" then
			vim.cmd("vertical resize -" .. amount)
		elseif char == "k" then
			vim.cmd("resize +" .. amount)
		elseif char == "j" then
			vim.cmd("resize -" .. amount)
		elseif char == "q" or key == 27 or key == 13 or key == 10 then
			break
		end
		vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
	end
	vim.api.nvim_echo({ { "", "Normal" } }, false, {})
end, { desc = "Window resize mode" })

-- Shift-K lookup menu (man / tldr / web)
local function lookup_word(word)
	if not word or word == "" then
		return
	end

	local options = {}
	local actions = {}

	if vim.fn.system("man -w " .. vim.fn.shellescape(word) .. " 2>/dev/null"):match("%S") then
		table.insert(options, "man")
		actions["man"] = function()
			vim.cmd("Man " .. vim.fn.fnameescape(word))
		end
	end

	if vim.fn.executable("tldr") == 1 then
		table.insert(options, "tldr")
		actions["tldr"] = function()
			vim.cmd("split | terminal tldr " .. vim.fn.shellescape(word))
		end
	end

	table.insert(options, "web browser")
	actions["web browser"] = function()
		vim.fn.jobstart({ "firefox", "--search", "What is " .. word }, { detach = true })
	end

	vim.ui.select(options, { prompt = "Look up: " .. word }, function(choice)
		actions[choice or "web browser"]()
	end)
end

vim.keymap.set("n", "K", function()
	lookup_word(vim.fn.expand("<cword>"))
end, { desc = "Lookup word (man/tldr/web)" })

vim.keymap.set("v", "K", function()
	local line_start, col_start = vim.fn.line("'<"), vim.fn.col("'<")
	local line_end, col_end = vim.fn.line("'>"), vim.fn.col("'>")
	local lines = vim.api.nvim_buf_get_text(0, line_start - 1, col_start - 1, line_end - 1, col_end, {})
	lookup_word(table.concat(lines, " "):match("^%s*(.-)%s*$"))
end, { desc = "Lookup selection (man/tldr/web)" })

vim.filetype.add({
	extension = {
		qrc = "xml",
		d2 = "d2",
	},
})
