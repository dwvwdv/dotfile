local function start_godot_pipe()
	if vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 1 then
		local addr = "./godot.pipe"
		if (vim.loop.os_uname().sysname == 'Windows_NT') then
			addr = "127.0.0.1:6004"
		end
		vim.fn.serverstart(addr)
	end
end

vim.api.nvim_create_user_command(
	"GodotConnect",
	start_godot_pipe,
	{ desc = "Starts the Godot pipe server if project.godot exists" }
)

GodotConnect = {}

function GodotConnect.Check()
	start_godot_pipe()
end

return GodotConnect
