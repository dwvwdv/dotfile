-- Windows Godot Config.
if (vim.loop.os_uname().sysname == 'Windows_NT')
-- You Need in Godot Application Add config
-- 1. Use External Editor: On
-- 2. Exec Path: nvim
-- 3. Exec Flags: --server "\\\\.\\pipe\\godot.pipe" --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"
then
	local port = os.getenv('GDScript_Port') or '6005'
	local cmd = {'ncat', '127.0.0.1', port}
	local pipe = [[\\.\pipe\godot.pipe]]

	vim.lsp.start({
		name = 'Godot',
		cmd = cmd,
		root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
		on_attach = function(client, bufnr)
			vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
		end
	})
end
