require("config.lazy")
local os_setup = require("os_setup.setup")

require("config.files.cabab_handling").setup()

-- require('config.lsp.enable').setup()

vim.opt.number = true
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
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:4"

vim.opt.spell = true
vim.opt.spelloptions = "camel"

vim.opt.diffopt:append("inline:word")
-- vim.opt.diffopt = "inline:word"

vim.opt.iskeyword:append("$")
-- vim.opt.iskeyword:append(":")

-- -- LSP Config
-- vim.lsp.config("qmlls", { cmd = { "qmlls6" } })
--
-- vim.lsp.enable({
-- 	"clangd",
-- 	"qmlls",
-- 	-- "harper_ls",
-- 	"rust_analyzer",
-- 	"lua_ls",
-- 	"yamlls",
-- 	"just",
-- 	"jedi_language_server",
-- 	"kotlin_lsp",
-- 	"neocmake",
-- 	"phpantom_lsp",
-- 	"tailwindcss",
-- 	"tombi",
-- })

vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { desc = "Vim Lsp Code Actions" })
vim.keymap.set("x", "g.", vim.lsp.buf.code_action, { desc = "Vim Lsp Code Actions (visual)" })
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, { desc = "Next LSP diagnostic" })
vim.keymap.set("n", "[d]", function()
	vim.diagnostic.goto_prev()
end, { desc = "Prev LSP diagnostic" })
vim.keymap.set("n", "<leader>gd", ":Neogen<CR>", { desc = "Generate annotation (Neogen)" })


-- vim.opt.tabstop = 4

local space = " "
vim.opt.listchars:append({
	tab = "——",
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
})
vim.opt.list = true

vim.g.mapleader = " "
vim.g.maplocalleader = ";"
-- vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.buffers, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope find keymaps" })

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

vim.filetype.add({
	extension = {
		qrc = "xml",
		d2 = "d2",
	},
	filename = {
		[".justfile"] = "just",
		["justfile"] = "just",
	},
})

-- Alias composite filetypes used by LSP configs so Neovim doesn't warn "Unknown filetype"
-- for _, filetype in ipairs({ "c.doxygen", "cpp.doxygen", "qmljs" }) do
-- 	local existing = vim.filetype.match({ filename = "file." .. filetype })
-- 	if not existing then
-- 		vim.treesitter.language.register("c", filetype)
-- 		vim.filetype.add({ pattern = { [".*\\." .. vim.pesc(filetype) .. "$"] = filetype } })
-- 	end
-- end

sitting_langs = require("config.sitting_langs")

vim.api.nvim_create_autocmd("FileType", {
	pattern = sitting_langs,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.api.nvim_create_user_command("Cdfd", "cd %:p:h", { desc = "cd to the directory the current file is in" })

vim.keymap.set("n", "<leader>qk", function()
	local out = vim.fn.system({
		"kitty",
		"@",
		"get-text",
		"--match",
		"recent:1",        -- the window you were in before nvim
		"--extent",
		"last_non_empty_output", -- just the last command's output
	})
	vim.fn.setqflist({}, " ", {
		title = "kitty",
		lines = vim.split(out, "\n"),
		efm = vim.o.errorformat,
	})
	vim.cmd("copen")
end, { desc = "Kitty last output -> quickfix" })

-- vim.lsp.config("laravel_lsp", {
--     cmd = { "laravel-lsp" },
--     filetypes = { "php", "blade" },
--     root_dir = function(bufnr, on_dir)
--         local root = vim.fs.root(bufnr, "artisan")
--
--         if root then
--             on_dir(root)
--         end
--     end,
-- })

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
--
-- vim.lsp.enable("laravel_lsp")
