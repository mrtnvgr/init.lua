local check_command = "check"

-- Use clippy if it's installed
local Job = require("plenary.job")
Job:new({
	command = "cargo",
	args = { "clippy", "-V" },
	on_exit = function(_, code)
		if code == 0 then
			check_command = "clippy"
		end
	end,
}):sync()

return {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = check_command,
			},
		},
	},
}
