initlua.configure = {}

for _, module in ipairs({ "optional_plugins", "languages" }) do
	require("initlua.utils.configure." .. module)
end

function initlua.configure.all()
	local async = require("plenary.async")

	-- REFACTOR: this
	vim.ui.async = {}
	vim.ui.async.select = async.wrap(function(items, opts, callback)
		vim.ui.select(items, opts, callback)
	end, 3)

	async.void(function()
		local looping_here = true
		while looping_here do
			local opts = { "Optional Plugins", "Language Integrations", "Quit" }
			local choice = vim.ui.async.select(opts, { prompt = "Select options" })

			if choice == "Optional Plugins" then
				initlua.configure.optional_plugins()
			elseif choice == "Language Integrations" then
				initlua.configure.languages()
			else
				looping_here = false
			end
		end
	end)()
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
