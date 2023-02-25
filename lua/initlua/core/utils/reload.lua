local create_command = vim.api.nvim_create_user_command

create_command("InitluaReload", function()
	local reload_module = require("plenary.reload").reload_module

	local reloaded = true

	for name, _ in pairs(package.loaded) do
		if name:match("^initlua.core") then
			local status, _ = pcall(reload_module, name)
			local status2, _ = pcall(require, name)
			if not status or not status2 then
				reloaded = false
				break
			end
		end
	end

	if reloaded then
		initlua.notify("Reloaded successfully")
	else
		initlua.err("Failed to reload")
	end
end, { desc = "Reload All Stuff" })
