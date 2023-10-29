Exec = {}

function Exec.Save()
	-- TODO: save file
	-- vim.api.nvim_command('write')
	vim.cmd("silent! write")
end

function Exec.Compiler()
	Exec.Save()
	-- vim.print('compiler function執行')
	local execCommand = ''
	-- Get the file's extension

	if vim.fn.expand('%:e') == "py" then
		execCommand = '<cmd>TermExec cmd="python %"<cr>'
	elseif vim.fn.expand('%:e') == 'go' then
		execCommand = '<cmd>TermExec cmd="go run %"<cr>'
	elseif vim.fn.expand('%:e') == 'cs' then
		execCommand = '<cmd>TermExec cmd="dotnet run"<cr>'
	elseif vim.fn.expand('%:e') == 'dart' then
		execCommand = '<cmd>FlutterRun<cr>'
	else
		execCommand = string.format('<cmd>echo "Sorry, your filetype is unknown for %s"<cr>', vim.fn.expand('%:t'))
	end
	return execCommand
end

-- Register autocmd
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.keymap.set("n", "<F5>", Exec.Compiler(), { silent = true, buffer = true })
	end
})

-- vim.print('Exec模塊執行')

return Exec
