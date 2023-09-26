return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true,
		keys = {
			{ "<leader>tl", "<cmd>ToggleTerm<cr>", desc = "toggleterm" },
			{ "<F5>",require('lib.Exec').Compiler(), desc = "Run Current File" },
		}
	},
}
