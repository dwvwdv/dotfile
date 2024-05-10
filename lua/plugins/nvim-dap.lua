return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'mfussenegger/nvim-dap-python',
		'nvim-neotest/nvim-nio'
	},
	lazy = false,
	enable = true,
	keys = {
		-- vim.keymap.set({"i", "n", "v"}, "<C-F5>", "<cmd>lua require'dap'.continue()<CR>", {silent = true, noremap = true, buffer = bufnr}),
		-- vim.keymap.set({"i", "n", "v"}, "<F10>", "<cmd>lua require'dap'.step_over()<CR>", {silent = true, noremap = true, buffer = bufnr}),
		-- vim.keymap.set({"i", "n", "v"}, "<F11>", "<cmd>lua require'dap'.step_into()<CR>", {silent = true, noremap = true, buffer = bufnr}),
		-- vim.keymap.set({"i", "n", "v"}, "<F12>", "<cmd>lua require'dap'.step_over()<CR>", {silent = true, noremap = true, buffer = bufnr}),
		-- vim.keymap.set({"i", "n", "v"}, "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {silent = true, noremap = true, buffer = bufnr})
		vim.keymap.set('n', '<C-F5>', function() require('dap').continue() end),
		-- vim.keymap.set('n', '<S-F5>', function() require('dap').run() end),
		vim.keymap.set('n', '<F10>', function() require('dap').step_over() end),
		vim.keymap.set('n', '<F11>', function() require('dap').step_into() end),
		vim.keymap.set('n', '<F12>', function() require('dap').step_out() end),
		vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end),
		vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end),
		vim.keymap.set('n', '<Leader>lp',
			function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end),
		vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end),
		vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end),
		vim.keymap.set('n', '<Leader>db', function() require("dapui").toggle() end),

	},
	config = function()
		vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
		-- require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python')
		require("dapui").setup()
		require('dap-python').setup('C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python311\\python.exe')
	end
}
