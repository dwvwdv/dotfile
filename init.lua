
function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function imap(shortcut, command)
	map('i', shortcut, command)
end

function tmap(shortcut, command)
	map('t', shortcut, command)
end

-- Modify  Leader Key 
vim.g.mapleader = ' '

-- Control File Enconding
-- vim.o.encoding='utf-8'
vim.o.termencoding='utf-8'
vim.o.fileencoding='utf-8'

-- Basic Setting
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.sidescroll=1
-- vim.o.cmdheight=0

-- Tab Indent
vim.o.tabstop=4
vim.o.shiftwidth=4

-- Auto Switch Directory
vim.o.autochdir = true

-- Auto Complete Quote
imap("(","()<Left>")
imap("[","[]<Left>")
--imap("<","<><Esc>i")
imap("{<CR>","{}<Left><CR><CR><Up><TAB>")
imap("\"","\"\"<Left>")
imap("'","''<Left>")

-- Quick Move
nmap("<SPACE><CR>",":nohlsearch<CR>")
nmap("<SPACE>j","20jzz")
nmap("<SPACE>k","20kzz")

-- Neovim Config Modify
nmap("<F8>",":tabe<CR>:e $MYVIMRC<CR>")
nmap("R",":Lazy<CR>")

-- Defalut Key Config Modify
nmap("s","<nop>")
nmap("t","<nop>")
nmap("T","<nop>")
nmap("K","<nop>")
nmap("W","5w")
nmap("S",":w<CR>")
nmap("Q",":q<CR>")

-- Tarminal Defalut Config Modify
tmap("<A-s>","<C-\\><C-n>")

-- Window Split
nmap("sh",":set nosplitright<CR>:vsplit<CR>")
nmap("sl",":set splitright<CR>:vsplit<CR>")
nmap("sj",":set splitbelow<CR>:split<CR>")
nmap("sk",":set nosplitbelow<CR>:split<CR>")

-- open vim explorer
nmap("sd","sh:Ex<CR>:vertical resize -15<CR>")

-- Tab Switch
nmap("st",":tabe<CR>")
nmap("sp","gT")
nmap("sn","gt")

-- Pin Tab
nmap("tt",":tabm 0<CR>")

-- Buffer Switch
nmap("<A-j>",":bnext<CR>")
nmap("<A-k>",":bprevious<CR>")
nmap("<A-h>",":bfirst<CR>")
nmap("<A-l>",":blast<CR>")
nmap("<A-c>",":%bd|e#<CR>")

-- Auto Indent
nmap("!","gg=G``")

-- Terminal and Compiler
nmap("tl :vim.o.splitbelow<CR> :terminal","++rows=7<CR>")
nmap("<F5>",":call CompileRunGcc()<CR>")
nmap("<F6>",":!cls<CR><CR>:call SSHCompileRunGcc()<CR>")

-- Move Code
map("n", "<C-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<C-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<C-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<C-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

vim.cmd([[
" Clipboard Linked 
set clipboard=unnamed 
" Backspace Work 
set backspace=indent,eol,start
" Last Edit Locatoin
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" File Hightligt Code
filetype indent on
syntax on
exec "nohlsearch"
let g:python3_host_prog = 'C:\Users\user\AppData\Local\Programs\Python\Python311\python'

func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!gcc % -o %<"
elseif &filetype == 'cpp'
exec "silent !start cmd.exe /C g++ % -o %< && %< & pause"
elseif &filetype == 'java'
exec "!javac %"
exec "!time java %<"
elseif &filetype == 'sh'
:!time bash %
elseif &filetype == 'python'
exec "silent !start cmd.exe /C python % & pause"
elseif &filetype == 'html'
exec "! chrome % &"
endif
endfunc
]])

----------------------------- Plugin --------------------------------
local range = 20

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({{import = "plugins"}})

-- neotree plugin
require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil , -- use a custom function for sorting files and directories in the tree 
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	default_component_configs = {
		container = {
			enable_character_fade = true
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon"
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✖",-- this can only be used in the git_status source
				renamed   = "",-- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "",
				staged    = "",
				conflict  = "",
			}
		},
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-global-custom-commands`
	commands = {},
	window = {
		position = "left",
		width = 40,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = { 
				"toggle_node", 
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
			},
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "revert_preview",
			["P"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "focus_preview",
			[","] = "open_split",
			["."] = "open_vsplit",
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			["a"] = { 
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none" -- "none", "relative", "absolute"
				}
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		}
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				--"node_modules"
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = false, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
			},
		},

		commands = {} -- Add a custom command or override a global one using the same function name
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
			}
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			}
		}
	}
})


vim.cmd([[
	color nord
	"hi CursorLine   cterm=NONE ctermbg=237 ctermfg=white guibg=darkred guifg=white
	"so C:\Users\user\AppData\Local\nvim\config\coc-config.vim
	so C:\Users\user\AppData\Local\nvim\config\floatTerm-config.vim
]])

-- floatTerm plugin
nmap("tl",":FloatermNew<CR>")
-- lazygit plugin
nmap("<SPACE>gg",":LazyGit<CR>")
-- neotree plugin
nmap("<SPACE>t",":NeoTreeFocusToggle<CR>")
nmap("\\",":cd ~<CR>")
-- MarkdownPreview plugin
nmap("<SPACE>m","<Plug>MarkdownPreview")

-- telescope plugin
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fo', builtin.loclist, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})

-- leap plugin
-- require('leap').add_default_mappings()
-- nmap('ss','<Plug>(leap-forward-to)')
-- nmap('sd','<Plug>(leap-backward-to)')


-- indent-blankline plugin
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup {
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
}

-- gitsigns plugin
require('gitsigns').setup {
	signs = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
			end, {expr=true})

		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
			end, {expr=true})

		-- Actions
		-- map('n', '<leader>hs', gs.stage_hunk)
		-- map('n', '<leader>hr', gs.reset_hunk)
		-- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
		-- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
		-- map('n', '<leader>hS', gs.stage_buffer)
		-- map('n', '<leader>hu', gs.undo_stage_hunk)
		-- map('n', '<leader>hR', gs.reset_buffer)
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>hb', function() gs.blame_line{full=true} end)
		map('n', '<leader>tb', gs.toggle_current_line_blame)
		map('n', '<leader>hd', gs.diffthis)
		map('n', '<leader>hD', function() gs.diffthis('~') end)
		map('n', '<leader>td', gs.toggle_deleted)

		-- Text object
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}

-- nvim-treesitter plugin
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query" , "python", "go", "json" },

	-- -- Install parsers synchronously (only applied to `ensure_installed`)
	-- sync_install = false,

	-- -- Automatically install missing parsers when entering buffer
	-- -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	-- auto_install = true,

	-- -- List of parsers to ignore installing (for "all")
	-- ignore_install = { "jabascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = {},
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		-- disable = function(lang, buf)
		--     local max_filesize = 100 * 1024 -- 100 KB
		--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		--     if ok and stats and stats.size > max_filesize then
		--         return true
		--     end
		-- end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	}
}

-- ChatGPT plugin
require("chatgpt").setup({
	api_key_cmd = nil,
	yank_register = "+",
	edit_with_instructions = {
		diff = false,
		keymaps = {
			accept = "<C-y>",
			toggle_diff = "<C-d>",
			toggle_settings = "<C-o>",
			cycle_windows = "<Tab>",
			use_output_as_input = "<C-i>",
		},
	},
	chat = {
		welcome_message = WELCOME_MESSAGE,
		loading_text = "Loading, please wait ...",
		question_sign = "",
		answer_sign = "ﮧ",
		max_line_length = 120,
		sessions_window = {
			border = {
				style = "rounded",
				text = {
					top = " Sessions ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		keymaps = {
			close = { "<C-c>" },
			yank_last = "<C-y>",
			yank_last_code = "<C-k>",
			scroll_up = "<C-u>",
			scroll_down = "<C-d>",
			new_session = "<C-n>",
			cycle_windows = "<Tab>",
			cycle_modes = "<C-f>",
			select_session = "<Space>",
			rename_session = "r",
			delete_session = "d",
			draft_message = "<C-d>",
			toggle_settings = "<C-o>",
			toggle_message_role = "<C-r>",
			toggle_system_role_open = "<C-s>",
		},
	},
	popup_layout = {
		default = "center",
		center = {
			width = "80%",
			height = "80%",
		},
		right = {
			width = "30%",
			width_settings_open = "50%",
		},
	},
	popup_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " ChatGPT ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "1",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		buf_options = {
			filetype = "markdown",
		},
	},
	system_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " SYSTEM ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "2",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	popup_input = {
		prompt = "  ",
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top_align = "center",
				top = " Prompt ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		submit = "<C-Enter>",
		submit_n = "<Enter>",
	},
	settings_window = {
		border = {
			style = "rounded",
			text = {
				top = " Settings ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	openai_params = {
		model = "gpt-3.5-turbo",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 300,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	openai_edit_params = {
		model = "code-davinci-edit-001",
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	actions_paths = {},
	show_quickfixes_cmd = "Trouble quickfix",
	predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
})
nmap('<SPACE>ai',':ChatGPT<CR>')
nmap('<SPACE>ae',':ChatGPTEditWithInstructions<CR>')
nmap('<SPACE>ac',':ChatGPTCompleteCode<CR>')

-- lspconfig plugin
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
			end, opts)
	end,
})

-- cmp plugin

-- lsp-setup plugin 
require('lsp-setup').setup({
	servers = {
		pyright = {
			capabilities = capabilities
		},
		gopls = {
			capabilities = capabilities
		},
		csharp_ls = {
			capabilities = capabilities
		},
	}
})

-- mason plugin
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})
nmap("tr",":Mason<CR>")

-- mason-lspconfig plugin
require("mason-lspconfig").setup{
	ensure_installed = { "gopls", "pyright" ,"csharp_ls"}
}

-- symbols-outline plugin
local symbols_outline_opts = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = 'right',
	relative_width = true,
	width = 25,
	auto_close = false,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = true,
	preview_bg_highlight = 'Pmenu',
	autofold_depth = nil,
	auto_unfold_hover = true,
	fold_markers = { '', '' },
	wrap = false,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = {"<Esc>", "q"},
		goto_location = "<CR>",
		focus_location = "o",
		hover_symbol = "p",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
		fold = "h",
		unfold = "l",
		fold_all = "W",
		unfold_all = "E",
		fold_reset = "R",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = "", hl = "@text.uri" },
		Module = { icon = "", hl = "@namespace" },
		Namespace = { icon = "", hl = "@namespace" },
		Package = { icon = "", hl = "@namespace" },
		Class = { icon = "𝓒", hl = "@type" },
		Method = { icon = "ƒ", hl = "@method" },
		Property = { icon = "", hl = "@method" },
		Field = { icon = "", hl = "@field" },
		Constructor = { icon = "", hl = "@constructor" },
		Enum = { icon = "ℰ", hl = "@type" },
		Interface = { icon = "ﰮ", hl = "@type" },
		Function = { icon = "", hl = "@function" },
		Variable = { icon = "", hl = "@constant" },
		Constant = { icon = "", hl = "@constant" },
		String = { icon = "𝓐", hl = "@string" },
		Number = { icon = "#", hl = "@number" },
		Boolean = { icon = "⊨", hl = "@boolean" },
		Array = { icon = "", hl = "@constant" },
		Object = { icon = "⦿", hl = "@type" },
		Key = { icon = "🔐", hl = "@type" },
		Null = { icon = "NULL", hl = "@type" },
		EnumMember = { icon = "", hl = "@field" },
		Struct = { icon = "𝓢", hl = "@type" },
		Event = { icon = "🗲", hl = "@type" },
		Operator = { icon = "+", hl = "@operator" },
		TypeParameter = { icon = "𝙏", hl = "@parameter" },
		Component = { icon = "", hl = "@function" },
		Fragment = { icon = "", hl = "@constant" },
	},
}
require("symbols-outline").setup(symbols_outline_opts)
nmap("sy",":SymbolsOutline<CR>")


-- -- nvim-dap plugin
-- vim.keymap.set({"i", "n", "v"}, "<C-F5>", "<cmd>lua require'dap'.continue()<CR>", {silent = true, noremap = true, buffer = bufnr})
-- vim.keymap.set({"i", "n", "v"}, "<F10>", "<cmd>lua require'dap'.step_over()<CR>", {silent = true, noremap = true, buffer = bufnr})
-- vim.keymap.set({"i", "n", "v"}, "<F11>", "<cmd>lua require'dap'.step_into()<CR>", {silent = true, noremap = true, buffer = bufnr})
-- vim.keymap.set({"i", "n", "v"}, "<F12>", "<cmd>lua require'dap'.step_over()<CR>", {silent = true, noremap = true, buffer = bufnr})
-- vim.keymap.set({"i", "n", "v"}, "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {silent = true, noremap = true, buffer = bufnr})
-- 
-- require('dap/python')
-- 
-- local dap = require('dap')
-- dap.configurations.python = {
--   {
-- 	type = 'python';
-- 	request = 'launch';
-- 	name = "Launch file";
-- 	program = "${file}";
-- 	pythonPath = function()
-- 	  return 'C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python311\\python.exe'
-- 	end;
--   },
-- }
