if io.open(initlua.cache.path, "r") == nil then
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		once = true,
		callback = function()
			vim.ui.select({ "Yes", "No" }, { prompt = "Do you want to enable wakatime?" }, function(choice)
				if choice == "Yes" then
					initlua.settings.optional_plugins.wakatime = true
					initlua.notify("Wakatime will be enabled after restart")
				end
			end)
		end,
	})
end

return {
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
		enabled = initlua.settings.optional_plugins.wakatime,
	},
}
