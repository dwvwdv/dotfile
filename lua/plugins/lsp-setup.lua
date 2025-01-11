return {
	'junnplus/lsp-setup.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		'williamboman/mason.nvim',         -- optional
		'williamboman/mason-lspconfig.nvim', -- optional
	},
	config = function()
		require('lsp-setup').setup({
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			inlay_hints = {
				enabled = false,
				highlight = 'Comment',
			},
			servers = {
				-- tsserver = { },
				ts_ls = {},
				emmet_ls = {},
				angularls = {},
				cssls = {},
				-- csharp_ls = {},
				omnisharp = {},
				sqls = {},
			},
			on_attach = function(client, bufnr)
				-- Support custom the on_attach function for global
				-- Formatting on save as default
				-- require('lsp-setup.utils').format_on_save(client)
			end,
		})
	end,
}
