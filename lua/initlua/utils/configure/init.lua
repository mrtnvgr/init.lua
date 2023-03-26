initlua.configure = {}

for _, module in ipairs({ "optional_plugins", "languages" }) do
	require("initlua.utils.configure." .. module)
end

function initlua.configure.all()
	local opts = { "Optional Plugins", "Language Integrations", "Colorschemes" }
	table.sort(opts)
	table.insert(opts, "Quit")

	vim.ui.select(opts, { prompt = "Select options" }, function(choice)
		if choice == "Optional Plugins" then
			initlua.configure.optional_plugins()
		elseif choice == "Language Integrations" then
			initlua.configure.languages()
		elseif choice == "Colorschemes" then
			initlua.colorscheme.select()
		end
	end)
end

vim.api.nvim_create_autocmd("User", {
	desc = "Run configure dialog on the first time",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if io.open(initlua.cache.path, "r") ~= nil then
			return
		end

		initlua.notify(
			"Welcome to **Init.lua**!\n\nUse `:InitluaConfigure` to open a configuration.",
			vim.log.levels.INFO,
			{
				on_open = function(win)
					local buf = vim.api.nvim_win_get_buf(win)
					vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
				end,
			}
		)
	end,
})

vim.api.nvim_create_user_command("InitluaConfigure", initlua.configure.all, { desc = "Configure Initlua" })
vim.keymap.set("n", "<leader>ac", initlua.configure.all)
