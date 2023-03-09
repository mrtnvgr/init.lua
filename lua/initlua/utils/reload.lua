function initlua.reload()
	local reloaded = true

	for name, _ in pairs(package.loaded) do
		if name:match("^initlua") and not name:match("^initlua.plugins") then
			package.loaded[name] = nil
			local status, _ = pcall(require, name)
			if not status then
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
