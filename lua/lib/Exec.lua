Exec = {}

function Exec.Compiler()
	local execCommand = ''
	local file_extension = vim.fn.expand('%:e') -- Get the file's extension

	if file_extension == "py" then 
		execCommand = '<cmd>TermExec cmd="python %"<cr>'
	elseif file_extension == 'go' then
		execCommand = '<cmd>TermExec cmd="go run %"<cr>'
	elseif file_extension == 'dart' then
		execCommand = '<cmd>TermExec cmd="flutter run %"<cr>'
	else
		execCommand = string.format('<cmd>echo "Sorry, your filetype is unknown for %s"<cr>', vim.fn.expand('%:t'))
	end
	return execCommand
end


return Exec
