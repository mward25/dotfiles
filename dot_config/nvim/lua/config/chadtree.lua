return {
	"ms-jpq/chadtree",
	branch = "chad",
	build = "python3 -m chadtree deps",
	-- build = function()
	-- 	'python3 -m chadtree deps',
	-- end,
	keys = {
		--vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>")
		{ "<Leader>t", ":CHADopen<CR>", desc = "Open CHAD tree" },
	},
	init = function()
		-- vim.g.chadtree_settings = {
		-- 	theme = {
		-- 		text_colour_set = "nord", -- or "solarized_dark", "solarized_light", "trapdoor"
		-- 	},
		-- }
		vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
			callback = function(args)
				if vim.bo[args.buf].filetype:lower() == "chadtree" then
					vim.wo.spell = false
				end
			end,
		})
	end,
}
