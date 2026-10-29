return {
	"mason-org/mason-lspconfig.nvim",
	depends = {
		require("config.mason"),
		require("config.lspconfig"),
	},
	opts = {
		automatic_enable = true
	}
}
