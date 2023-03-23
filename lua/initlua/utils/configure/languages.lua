local settings_languages = {
	Python = {
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
	Rust = {
		lsp_enabled = false,
		lsp_servers = {
			"rust-analyzer",
		},

		null_ls_enabled = false,
		null_ls_servers = {
			"rustfmt", -- Formatter
		},
	},
	Lua = {
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
		-- local languages = vim.tbl_keys(initlua.settings.languages)

		local languages = {}
		for key, value in pairs(initlua.settings.languages) do
			local all_enabled = value.lsp_enabled and value.null_ls_enabled
			local only_lsp_enabled = value.lsp_enabled and not value.null_ls_enabled
			local only_null_ls_enabled = value.null_ls_enabled and not value.lsp_enabled
			local pretty_state = (all_enabled and "All")
				or (only_lsp_enabled and "Only LSP")
				or (only_null_ls_enabled and "Only null-ls")

			table.insert(languages, key .. " (" .. pretty_state .. ")")
		end

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

	local changes = false

	if type == "LSP" or type == "All" then
		initlua.settings.languages[language].lsp_enabled = boolean
		initlua.notify(language .. ": LSP integration was " .. pretty_name)
		changes = true
	end

	if type == "Formatters, linters, etc..." or type == "All" then
		initlua.settings.languages[language].null_ls_enabled = boolean
		initlua.notify(language .. ": null-ls integration was " .. pretty_name)
		changes = true
	end

	if changes then
		initlua.notify("New settings will be applied after restart")
	end
end
