local settings = {
	optional_plugins = {
		wakatime = false,
	},
}

initlua.settings = vim.tbl_deep_extend("force", settings, initlua.settings)

function initlua.configure.optional_plugins()
	while true do
		local plugins = {}
		for key, value in pairs(initlua.settings.optional_plugins) do
			local pretty_state = (value and "enabled") or "disabled"
			table.insert(plugins, key .. " (" .. pretty_state .. ")")
		end

		table.sort(plugins)
		table.insert(plugins, "<-")

		local plugin = vim.ui.async.select(plugins, { prompt = "Optional plugins" })
		if not plugin or plugin == "<-" then
			return
		end

		initlua.configure.optional_plugin(plugin)
	end
end

function initlua.configure.optional_plugin(plugin)
	local prompt = "Optional plugin: " .. plugin
	local choice = vim.ui.async.select({ "Enable", "Disable", "<-" }, { prompt = prompt })
	if not choice or choice == "<-" then
		return
	end

	local boolean = choice == "Enable"
	local pretty_value = (choice == "Enable" and "enabled") or "disabled"

	initlua.settings.optional_plugins[plugin] = boolean
	initlua.notify(plugin .. " will be " .. pretty_value .. " after restart")
end
