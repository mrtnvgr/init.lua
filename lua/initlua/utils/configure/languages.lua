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
			"selene", -- Linter
		},
	},
	LaTeX = {
		lsp_enabled = false,
		lsp_servers = { "ltex" },

		null_ls_enabled = false,
		null_ls_servers = {
			"latexindent", -- Formatter
		},
	},
}

if not initlua.settings.languages then
	initlua.settings.languages = {}
end

initlua.settings.languages = vim.tbl_deep_extend("keep", initlua.settings.languages, settings_languages)

function initlua.configure.languages()
	local languages = vim.tbl_keys(initlua.settings.languages)

	table.sort(languages)
	table.insert(languages, "<-")

	vim.ui.select(languages, {
		prompt = "Languages",
		format_item = function(language)
			local value = initlua.settings.languages[language]
			if not value then
				return language
			end

			local all_enabled = value.lsp_enabled and value.null_ls_enabled
			local only_lsp_enabled = value.lsp_enabled and not value.null_ls_enabled
			local only_null_ls_enabled = value.null_ls_enabled and not value.lsp_enabled

			local pretty_state = "Disabled"
			if only_lsp_enabled then
				pretty_state = "LSP"
			elseif only_null_ls_enabled then
				pretty_state = "Null-ls"
			elseif all_enabled then
				pretty_state = "All"
			end

			return "[" .. pretty_state .. "] " .. language
		end,
	}, function(language)
		if not language then
			return
		elseif language == "<-" then
			vim.schedule(initlua.configure.all)
			return
		end

		initlua.configure.language(language)
	end)
end

function initlua.configure.language(language)
	local prompt = language .. ": integration type"
	local choices = { "All", "LSP", "Null-ls", "<-" }
	vim.ui.select(choices, { prompt = prompt }, function(type)
		if not type then
			return
		elseif type == "<-" then
			vim.schedule(initlua.configure.languages)
			return
		end

		prompt = language .. ": " .. type .. " integration state"
		vim.ui.select({ "Enable", "Disable", "<-" }, { prompt = prompt }, function(state)
			if not state then
				return
			elseif state == "<-" then
				vim.schedule(initlua.configure.languages)
				return
			end

			local boolean = state == "Enable"
			local pretty_name = (state == "Enable" and "enabled") or "disabled"

			local changes = false

			if type == "LSP" or type == "All" then
				initlua.settings.languages[language].lsp_enabled = boolean
				initlua.notify(language .. ": LSP integration was " .. pretty_name)
				changes = true
			end

			if type == "Null-ls" or type == "All" then
				initlua.settings.languages[language].null_ls_enabled = boolean
				initlua.notify(language .. ": null-ls integration was " .. pretty_name)
				changes = true
			end

			if changes then
				initlua.notify("New settings will be applied after restart")
			end
		end)
	end)
end
