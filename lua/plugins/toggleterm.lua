return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true,
		lazy = false,
		keys = {
			{ "<C-\\>", ":ToggleTerm<cr>",          desc = "toggleterm" },
			{ "<F5>",   require('lib.Exec').Compiler(), desc = "Run Current File" },
		}
	},
}
