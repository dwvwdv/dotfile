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
				tsserver = {
					capabilities = capabilities
				},
				emmet_ls = {
					capabilities = capabilities
				},
				angularls = {
					capabilities = capabilities
				},
				cssls = {
					capabilities = capabilities
				},
			}
		})
	end
}


