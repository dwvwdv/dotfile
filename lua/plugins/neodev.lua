return {
	"folke/neodev.nvim",
	opts = {};
	config = function()
		require("neodev").setup({
			-- add any options here, or leave empty to use the default settings
		})

		local lspconfig = require('lspconfig')

		-- example to setup lua_ls and enable call snippets
		lspconfig.lua_ls.setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						checkThirdParty = false,
					},
				}
			}
		})
	end
}
