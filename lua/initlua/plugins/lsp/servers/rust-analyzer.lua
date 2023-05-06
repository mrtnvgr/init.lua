local check = {}

-- Use clippy if it's installed
local Job = require("plenary.job")
Job:new({
	command = "cargo",
	args = { "clippy", "-V" },
	on_exit = function(_, code)
		if code == 0 then
			check = {
				allFeatures = true,
				overrideCommand = {
					"cargo",
					"clippy",
					"--workspace",
					"--message-format=json",
					"--all-targets",
					"--all-features",
					"--",
					"-Wclippy::pedantic",
					"-Wclippy::nursery",
					-- 	"-Wclippy::unwrap_used",
					-- 	"-Wclippy::expect_used",
				},
			}
		else
			initlua.notify("rust-clippy is not installed", vim.log.levels.WARN)
		end
	end,
}):sync()

return {
	settings = {
		["rust-analyzer"] = {
			check = check,
		},
	},
}
