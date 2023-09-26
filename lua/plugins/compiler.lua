return { -- This plugin
	"Zeioth/compiler.nvim",
	cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
	dependencies = { "stevearc/overseer.nvim" },
	lazy = true,
	opts = {},
	config = function()
		require('compiler').setup({})
		-- Open compiler
		vim.api.nvim_buf_set_keymap(0, 'n', '<S-F5>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
		-- Redo last selected option
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', "<cmd>lua vim.cmd('CompilerStop')<CR><cmd>lua vim.cmd('CompilerRedo')<CR>", { noremap = true, silent = true })
		-- Toggle compiler results
		vim.api.nvim_buf_set_keymap(0, 'n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
	end
}
