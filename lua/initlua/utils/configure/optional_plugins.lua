function initlua.configure.optional_plugins(async_select)
	while true do
		local plugins = vim.tbl_keys(initlua.settings.optional_plugins)
		table.sort(plugins)
		table.insert(plugins, "<-")

		local plugin = async_select(plugins, { prompt = "Optional plugins" })
		if not plugin or plugin == "<-" then
			return
		end

		initlua.configure.optional_plugin(async_select, plugin)
	end
end

function initlua.configure.optional_plugin(async_select, plugin)
	local prompt = "Optional plugin: " .. plugin
	local choice = async_select({ "Enable", "Disable", "<-" }, { prompt = prompt })
	if not choice or choice == "<-" then
		return
	end

	local boolean = choice == "Enable"
	local pretty_value = (choice == "Enable" and "enabled") or "disabled"

	initlua.settings.optional_plugins[plugin] = boolean
	initlua.notify(plugin .. " will be " .. pretty_value .. " after restart")
end
