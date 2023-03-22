initlua.configure = {}

initlua.settings = {
	ui = {
		border = "single",
	},
	colorscheme = "rose-pine",
	optional_plugins = {
		wakatime = false,
	},
	languages = {
		python = {
			lsp_enabled = true,
			lsp_servers = {
				"pyright",
			},

			null_ls_enabled = true,
			null_ls_servers = {
				"black", -- Formatter
				"isort", -- Import formatter
				-- TODO: pyflakes
			},
		},
	},
	_internals = {
		update_available = false,
	},
}

function initlua.configure.optional_plugins(async_select)
	for plugin, _ in pairs(initlua.settings.optional_plugins) do
		local prompt = "Do you want to enable " .. plugin .. "?"
		local choice = async_select({ "Yes", "No" }, { prompt = prompt })
		if choice == "Yes" then
			initlua.settings.optional_plugins[plugin] = true
			initlua.notify(plugin .. " will be enabled after restart")
		end
	end
end

function initlua.configure.languages(async_select)
	for name, _ in pairs(initlua.settings.languages) do
		local prompt = name .. ": integration type"
		local choices = { "All", "LSP", "Null-ls" }
		local type = async_select(choices, { prompt = prompt })

		prompt = name .. ": " .. type .. " integration state"
		local state = async_select({ "Enable", "Disable" }, { prompt = prompt })

		local boolean = state == "Enable"
		local pretty_name = (state == "Enable" and "enabled") or "disabled"

		if type == "LSP" or type == "All" then
			initlua.settings.languages[name].lsp_enabled = boolean
			initlua.notify(name .. ": LSP integration was " .. pretty_name)
		end

		if type == "Formatters, linters, etc..." or type == "All" then
			initlua.settings.languages[name].null_ls_enabled = boolean
			initlua.notify(name .. ": null-ls integration was " .. pretty_name)
		end
	end
end

function initlua.configure.all()
	local async = require("plenary.async")
	local async_select = async.wrap(function(items, opts, callback)
		vim.ui.select(items, opts, callback)
	end, 3)

	async.void(function()
		initlua.configure.optional_plugins(async_select)

		local ok = async_select({ "Yes", "No" }, { prompt = "Do you want to setup language integrations?" })
		if ok then
			initlua.configure.languages(async_select)
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
