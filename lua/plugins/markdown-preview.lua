return{
	'iamcco/markdown-preview.nvim',
	build = function() vim.fn["mkdp#util#install"]() end,
	event = "VeryLazy",
	keys = {
		{"<Leader>m", "<Plug>MarkdownPreview", desc = "preview"},
	}
}
