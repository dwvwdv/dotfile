if (vim.loop.os_uname().sysname == 'Windows_NT')
then
	vim.cmd([[
	set shell=nu " pwsh
	set shellcmdflag=-c
	set shellxquote="{"
	]])
end

-- Godot FileSystem Open
if vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 1 then
	-- Exec Flags --server 127.0.0.1:6004 --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>
	local addr = "./godot.pipe"
	if (vim.loop.os_uname().sysname == 'Windows_NT') then
		-- Windows can't pipe so use localhost. Make sure this is configured in Godot
		addr = "127.0.0.1:6004"
	end
	vim.fn.serverstart(addr)
end

local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
	map('n', shortcut, command)
end

local function tmap(shortcut, command)
	map('t', shortcut, command)
end

-- Modify  Leader Key
vim.g.mapleader = ' '

-- Control File Enconding
-- vim.o.encoding='utf-8'
-- vim.o.termencoding = 'utf-8'
-- vim.o.fileencoding = 'utf-8'


-- Basic Setting
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = true
vim.o.wrap = true
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
nmap("<Space><F8>", ":tabe<CR>:e $MYVIMRC<CR>")
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
tmap("<Esc><Esc>", "<C-\\><C-n>")

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

-- Quick command
nmap("<A-p>", ":lua vim.print(")

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
set noswapfile
]])

-- Indent
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
-- g.markdown_folding = 1 -- enable markdown folding

----------------------------- Plugin --------------------------------
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
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

vim.api.nvim_create_user_command("ClearShada", function()
	local shada_path = vim.fn.expand(vim.fn.stdpath('data') .. "/shada")
	local files = vim.fn.glob(shada_path .. "/*", false, true)
	local all_success = 0
	for _, file in ipairs(files) do
		local file_name = vim.fn.fnamemodify(file, ":t")
		if file_name == "main.shada" then
			-- skip your main.shada file
			goto continue
		end
		local success = vim.fn.delete(file)
		all_success = all_success + success
		if success ~= 0 then
			vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
		end
		::continue::
	end
	if all_success == 0 then
		vim.print("Successfully deleted all temporary shada files")
	end
end,
	{ desc = "Clears all the .tmp shada files" }
)
