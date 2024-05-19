return {
	'nvim-telescope/telescope.nvim', tag = '0.1.6',
	-- or                              , branch = '0.1.1',
	dependencies = { 'nvim-lua/plenary.nvim' },
	event = "VeryLazy",
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
		vim.keymap.set('n', '<leader>fo', builtin.loclist, {})
		vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
		vim.keymap.set('n', '[q', require('lib.QuickfixToggle').toggle_qf, {})
	end
}
