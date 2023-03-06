function initlua.reload()
	local reload_module = require("plenary.reload").reload_module

	local reloaded = true

	for name, _ in pairs(package.loaded) do
		if not name:match("^initlua.plugins") then
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
end

vim.api.nvim_create_user_command("InitluaReload", initlua.reload, { desc = "Reload Everything" })
