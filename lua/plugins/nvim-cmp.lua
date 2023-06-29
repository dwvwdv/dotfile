return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',

		-- For vsnip users.
		-- 'hrsh7th/cmp-vsnip',
		-- 'hrsh7th/vim-vsnip',

		-- For luasnip users.
		-- 'L3MON4D3/LuaSnip',
		-- 'saadparwaiz1/cmp_luasnip',
		-- For ultisnips users.

		-- 'SirVer/ultisnips',
		-- 'quangnguyen30192/cmp-nvim-ultisnips',

		-- For snippy users.
		-- 'dcampos/nvim-snippy',
		-- 'dcampos/cmp-snippy',
	},
	event = "VeryLazy",
}

