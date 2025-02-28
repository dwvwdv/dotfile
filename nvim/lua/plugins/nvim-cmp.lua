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
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		-- For ultisnips users.

		-- 'SirVer/ultisnips',
		-- 'quangnguyen30192/cmp-nvim-ultisnips',

		-- For snippy users.
		-- 'dcampos/nvim-snippy',
		-- 'dcampos/cmp-snippy',
	},
	event = "VeryLazy",
	config = function()
		-- tab change 4 space can't work in insert mode
		-- table.unpack = table.unpack or unpack -- 5.1 compatibility

		-- local has_words_before = function()
		-- 	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
		-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		-- end
		-- Set up nvim-cmp.
		local cmp = require'cmp'
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					local luasnip = require("luasnip")
					if not luasnip then
						return
					end
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
				-- completion = { -- rounded border; thin-style scrollbar
				-- 	border = 'rounded',
				-- 	scrollbar = '║',
				-- },
				-- documentation = { -- no border; native-style scrollbar
				-- 	border = nil,
				-- 	scrollbar = '',
				-- 	-- other options
				-- },
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
				['<C-l>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
			})
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
				}, {
					{ name = 'cmdline' }
			})
		})

	end
}

