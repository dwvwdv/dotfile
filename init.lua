if (vim.loop.os_uname().sysname == 'Windows_NT')
then
	vim.cmd([[
	set shell=powershell
	set shellcmdflag=-command
	set shellquote=\"
	set shellxquote=
	]])
end

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
vim.o.termencoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- Basic Setting
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.sidescroll = 1
-- vim.o.cmdheight=0

-- Tab Indent
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Auto Switch Directory
vim.o.autochdir = true

-- Auto Complete Quote
-- imap("(","()<Left>")
-- imap("[","[]<Left>")
-- --imap("<","<><Esc>i")
-- imap("{<CR>","{}<Left><CR><CR><Up><TAB>")
-- imap("\"","\"\"<Left>")
-- imap("'","''<Left>")

-- Quick Move
nmap("<SPACE><CR>", ":nohlsearch<CR>")
nmap("<SPACE>j", "20jzz")
nmap("<SPACE>k", "20kzz")

-- Neovim Config Modify
nmap("<F8>", ":tabe<CR>:e $MYVIMRC<CR>")
nmap("R", ":Lazy<CR>")

-- Defalut Key Config Modify
nmap("s", "<nop>")
nmap("t", "<nop>")
nmap("T", "<nop>")
nmap("K", "<nop>")
nmap("W", "5w")
nmap("S", ":w<CR>")
nmap("Q", ":q<CR>")

-- Tarminal Defalut Config Modify
tmap("<A-s>", "<C-\\><C-n>")

-- Window Split
nmap("<Tab>sh", ":set nosplitright<CR>:vsplit<CR>")
nmap("<Tab>sl", ":set splitright<CR>:vsplit<CR>")
nmap("<Tab>sj", ":set splitbelow<CR>:split<CR>")
nmap("<Tab>sk", ":set nosplitbelow<CR>:split<CR>")
nmap("<A-->", ":resize -1<CR>")
nmap("<A-=>", ":resize +2<CR>")

-- Tab Swit<space>h
nmap("<Tab>t", ":tabe<CR>")
nmap("<Tab>p", "gT")
nmap("<Tab>n", "gt")
nmap("<A-n>", "<C-w><C-w>")

-- Pin Tab
nmap("tt", ":tabm 0<CR>")

-- Buffer Switch
nmap("<A-j>", ":bnext<CR>")
nmap("<A-k>", ":bprevious<CR>")
nmap("<A-h>", ":bfirst<CR>")
nmap("<A-l>", ":blast<CR>")
nmap("<A-c>", ":%bd|e#<CR>")

-- Auto Indent
nmap("!", "gg=G``")

-- Terminal and Compiler
nmap("tl :vim.o.splitbelow<CR> :terminal", "++rows=7<CR>")
nmap("<F5>", ":call CompileRunGcc()<CR>")
nmap("<F6>", ":!cls<CR><CR>:call SSHCompileRunGcc()<CR>")

-- Move Code
map("n", "<C-J>", "<cmd>m .+1<cr>==")
map("n", "<C-K>", "<cmd>m .-2<cr>==")
map("i", "<C-J>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<C-K>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<C-J>", ":m '>+1<cr>gv=gv")
map("v", "<C-K>", ":m '<-2<cr>gv=gv")

-- Session Control
map("n", "<Tab>ses", ":mks! ~/session/")
map("n", "<Tab>sel", ":source ~/session/")

-- Initial pwd
nmap("\\", ":cd ~<CR>")

-- Vim Script
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
require("lazy").setup({ {
	import = "plugins",
} })

-- Compiler

vim.cmd([[
	func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
	:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 --cmd="!gcc % -o %<"
	elseif &filetype == 'cpp'
	:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 --cmd="! g++ % -o %< && %<"
	elseif &filetype == 'java'
	exec "!javac %"
	exec "!time java %<"
	elseif &filetype == 'sh'
	:!time bash %
	elseif &filetype == 'python'
	:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 python %
	elseif &filetype == 'html'
	exec "! chrome % &"
	elseif &filetype == 'go'
	:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 go run %
	elseif &filetype == 'dart'
	:FlutterQuit
	:FlutterRun
	endif
	endfunc
]])

-- floatTerm plugin
nmap("tl", ":FloatermNew<CR>")
-- lazygit plugin
nmap("<SPACE>gg", ":LazyGit<CR>")
-- MarkdownPreview plugin
nmap("<SPACE>m", "<Plug>MarkdownPreview")
-- ChatGPT plugin
nmap('<SPACE>ai', ':ChatGPT<CR>')
nmap('<SPACE>ae', ':ChatGPTEditWithInstructions<CR>')
nmap('<SPACE>ac', ':ChatGPTCompleteCode<CR>')
-- mason plugin
nmap("tr", ":Mason<CR>")
-- symbols-outline plugin
nmap("<Tab>ol", ":SymbolsOutline<CR>")
-- flutter plugin
nmap("<F2>", ":FlutterEmulators<CR>")

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
