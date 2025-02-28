return {
	'echasnovski/mini.files',
	version = false,
	keys = {
		{'<tab><tab>', '<cmd>lua MiniFiles.open()<cr>'},
	},
	config = function()
		require('mini.files').setup({})
	end
}
