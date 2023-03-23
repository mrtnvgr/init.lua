local settings_languages = {
	python = {
		lsp_enabled = false,
		lsp_servers = {
			"pyright",
		},

		null_ls_enabled = false,
		null_ls_servers = {
			"black", -- Formatter
			"isort", -- Import formatter
			-- TODO: pyflakes
		},
	},
	rust = {
		lsp_enabled = false,
		lsp_servers = {
			"rust-analyzer",
		},

		null_ls_enabled = false,
		null_ls_servers = {
			"rustfmt", -- Formatter
		},
	},
	lua = {
		lsp_enabled = false,
		lsp_servers = {
			"lua_ls",
		},

		null_ls_enabled = false,
		null_ls_servers = {
			"stylua", -- Formatter
		},
	},
}

if not initlua.settings.languages then
	initlua.settings.languages = {}
end

initlua.settings.languages = vim.tbl_deep_extend("keep", initlua.settings.languages, settings_languages)

function initlua.configure.languages()
	while true do
		local languages = vim.tbl_keys(initlua.settings.languages)
		table.sort(languages)
		table.insert(languages, "<-")

		local language = vim.ui.async.select(languages, { prompt = "Languages" })
		if not language or language == "<-" then
			return
		end

		initlua.configure.language(language)
	end
end

function initlua.configure.language(language)
	local prompt = language .. ": integration type"
	local choices = { "All", "LSP", "Null-ls" }
	local type = vim.ui.async.select(choices, { prompt = prompt })

	prompt = language .. ": " .. type .. " integration state"
	local state = vim.ui.async.select({ "Enable", "Disable" }, { prompt = prompt })

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
