local check_command = "check"
local extraArgs = {}

-- Use clippy if it's installed
local Job = require("plenary.job")
Job:new({
	command = "cargo",
	args = { "clippy", "-V" },
	on_exit = function(_, code)
		if code == 0 then
			check_command = "clippy"
			extraArgs = {
				"--",
				"-Wclippy::pedantic",
				"-Wclippy::nursery",
				-- "-Wclippy::cargo",
				"-Wclippy::unwrap_used",
				"-Wclippy::expect_used",
			}
		else
			initlua.notify("rust-clippy is not installed", vim.log.levels.WARN)
		end
	end,
}):sync()

return {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = check_command,
				extraArgs = extraArgs,
			},
		},
	},
}
