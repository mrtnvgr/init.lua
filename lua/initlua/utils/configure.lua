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

-- TODO: BACK, async_select as local vars here

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
	initlua.notify(plugin .. "will be " .. pretty_value .. " after restart")
end

function initlua.configure.languages(async_select)
	while true do
		local languages = vim.tbl_keys(initlua.settings.languages)
		table.sort(languages)
		table.insert(languages, "<-")

		local language = async_select(languages, { prompt = "Languages" })
		if not language or language == "<-" then
			return
		end

		initlua.configure.language(async_select, language)
	end
end

function initlua.configure.language(async_select, language)
	local prompt = language .. ": integration type"
	local choices = { "All", "LSP", "Null-ls" }
	local type = async_select(choices, { prompt = prompt })

	prompt = language .. ": " .. type .. " integration state"
	local state = async_select({ "Enable", "Disable" }, { prompt = prompt })

	local boolean = state == "Enable"
	local pretty_name = (state == "Enable" and "enabled") or "disabled"

	if type == "LSP" or type == "All" then
		initlua.settings.languages[language].lsp_enabled = boolean
		initlua.notify(language .. ": LSP integration was " .. pretty_name)
	end

	if type == "Formatters, linters, etc..." or type == "All" then
		initlua.settings.languages[language].null_ls_enabled = boolean
		initlua.notify(language .. ": null-ls integration was " .. pretty_name)
	end
end

function initlua.configure.all()
	local async = require("plenary.async")
	local async_select = async.wrap(function(items, opts, callback)
		vim.ui.select(items, opts, callback)
	end, 3)

	async.void(function()
		local looping_here = true
		while looping_here do
			local opts = { "Optional Plugins", "Language Integrations", "Quit" }
			local choice = async_select(opts, { prompt = "Select options" })

			if choice == "Optional Plugins" then
				initlua.configure.optional_plugins(async_select)
			elseif choice == "Language Integrations" then
				initlua.configure.languages(async_select)
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
