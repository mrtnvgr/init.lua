local settings = {
	optional_plugins = {
		wakatime = false,
	},
}

initlua.settings = vim.tbl_deep_extend("force", settings, initlua.settings)

function initlua.configure.optional_plugins()
	local plugins = vim.tbl_keys(initlua.settings.optional_plugins)

	table.sort(plugins)
	table.insert(plugins, "<-")

	vim.ui.select(plugins, {
		prompt = "Optional plugins",
		format_item = function(plugin)
			local value = initlua.settings.optional_plugins[plugin]
			if value == nil then
				return plugin
			end

			local pretty_state = (value and "x") or " "
			return "[" .. pretty_state .. "] " .. plugin
		end,
	}, function(plugin)
		if not plugin then
			return
		elseif plugin == "<-" then
			vim.schedule(initlua.configure.all)
			return
		end

		local boolean = not initlua.settings.optional_plugins[plugin]
		initlua.settings.optional_plugins[plugin] = boolean
		vim.schedule(initlua.configure.optional_plugins)
	end)
end
