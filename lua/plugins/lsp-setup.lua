return {
	'junnplus/lsp-setup.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		'williamboman/mason.nvim',         -- optional
		'williamboman/mason-lspconfig.nvim', -- optional
	},
	config = function()
		require('lsp-setup').setup({
			inlay_hits = {
				enabled = true,
			},
			servers = {
				pyright = {
					capabilities = capabilities
				},
				gopls = {
					capabilities = capabilities
				},
				csharp_ls = {
					capabilities = capabilities
				},
				tsserver = {
					capabilities = capabilities
				},
				html = {
					capabilities = capabilities
				},
				lua_ls = {
					capabilities = capabilities
				},
			}
		})
	end
}
