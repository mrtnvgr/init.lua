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

			local pretty_state = (value and "enabled") or "disabled"
			return plugin .. " (" .. pretty_state .. ")"
		end,
	}, function(plugin)
		if not plugin then
			return
		elseif plugin == "<-" then
			vim.schedule(initlua.configure.all)
			return
		end

		initlua.configure.optional_plugin(plugin)
	end)
end

function initlua.configure.optional_plugin(choice)
	local prompt = "Optional plugin: " .. choice
	vim.ui.select({ "Enable", "Disable", "<-" }, { prompt = prompt }, function(choice)
		if not choice then
			return
		elseif choice == "<-" then
			vim.schedule(initlua.configure.optional_plugins)
			return
		end

		local boolean = choice == "Enable"
		local pretty_value = (choice == "Enable" and "enabled") or "disabled"

		initlua.settings.optional_plugins[choice] = boolean
		initlua.notify(choice .. " will be " .. pretty_value .. " after restart")
	end)
end
