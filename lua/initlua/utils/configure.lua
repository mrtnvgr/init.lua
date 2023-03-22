initlua.configure = {}

initlua.settings = {
	ui = {
		border = "single",
	},
	colorscheme = "rose-pine",
	optional_plugins = {
		wakatime = false,
	},
	_internals = {
		update_available = false,
	},
}

function initlua.configure.optional_plugins(async_select)
	for plugin, _ in pairs(initlua.settings.optional_plugins) do
		local prompt = "Do you want to enable " .. plugin .. "?"
		async_select({ "Yes", "No" }, { prompt = prompt }, function(choice)
			if choice == "Yes" then
				initlua.settings.optional_plugins[plugin] = true
				initlua.notify(plugin .. " will be enabled after restart")
			end
		end)
	end
end

function initlua.configure.all()
	local async = require("plenary.async")
	local async_select = async.wrap(function(items, opts, callback)
		vim.ui.select(items, opts, callback)
	end, 3)

	async.run(function()
		initlua.configure.optional_plugins(async_select)
	end, function() end)
end

vim.api.nvim_create_autocmd("User", {
	desc = "Run configure dialog on the first time",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if io.open(initlua.cache.path, "r") == nil then
			initlua.configure.all()
		end
	end,
})

vim.api.nvim_create_user_command("InitluaConfigure", initlua.configure.all, { desc = "Configure Initlua" })
vim.keymap.set("n", "<leader>ac", initlua.configure.all)
