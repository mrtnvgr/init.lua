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
