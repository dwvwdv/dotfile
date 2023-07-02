return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	config = function()
		-- luasnip plugin
		local ls = require("luasnip")
		local snip = ls.snippet
		local node = ls.snippet_node
		local text = ls.text_node
		local insert = ls.insert_node
		local func = ls.function_node
		local choice = ls.choice_node
		local dynamicn = ls.dynamic_node
		local date = function() return {os.date('%Y-%m-%d')} end

		-- ls.config.setup({ enable_autosnippets = true })
		ls.add_snippets(nil, {
			all = {
				snip({
					trig = "date",
					name = "Date",
					dscr = "Date in the form of YYYY-MM-DD",
					}, {
						func(date, {}),
				}),
			},
			-- snippetType = 'autosnippet'
		})
		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		-- keymap("i", "<c-J>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		-- keymap("s", "<c-J>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
		-- keymap("i", "<c-K>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
		-- keymap("s", "<c-K>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
	end



	-- install jsregexp (optional!).
	-- build = "make install_jsregexp"
}
