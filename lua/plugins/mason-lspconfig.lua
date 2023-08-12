return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		require("mason-lspconfig").setup{
			ensure_installed = { "gopls", "pyright" ,"csharp_ls","tsserver","html"}
		}
	end
}
