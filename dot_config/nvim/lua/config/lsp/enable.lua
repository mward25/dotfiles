return {
	setup = function ()
		lsps = require('config.lsp.lsps')
		vim.lsp.enable(lsps);
	end
}
