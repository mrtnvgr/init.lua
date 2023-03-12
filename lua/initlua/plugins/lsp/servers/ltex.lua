local function curbuf_uri()
	return vim.uri_from_bufnr(vim.api.nvim_get_current_buf())
end

local function create_autocmds()
	vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave", "BufWritePost" }, {
		group = "Initlua",
		buffer = vim.api.nvim_get_current_buf(),
		desc = "Check document",
		callback = function()
			local client = (vim.lsp.get_active_clients({ name = "ltex" }))[1]
			client.checkDocument()
		end,
	})
end

local function create_client_functions(client)
	client.checkDocument = function(uri)
		client.request(
			"workspace/executeCommand",
			{ command = "_ltex.checkDocument", arguments = { { uri = uri or curbuf_uri() } } }
		)
	end
end

local function on_init(client)
	create_client_functions(client)
	create_autocmds()
end

return {
	settings = {
		ltex = {
			-- https://valentjn.github.io/ltex/advanced-usage.html#magic-comments
			language = "en-US",
			additionalRules = {
				motherTongue = "ru-RU",
				enablePickyRules = true,
			},
			completionEnabled = true,
			disabledRules = {
				["en-US"] = {
					-- Write notes peacefully
					"UPPERCASE_SENTENCE_START",
					-- "I can use whatever symbol I want!"
					"COPYRIGHT",
					-- I think nobody uses these quotes digitally...
					"EN_QUOTES",
					-- I love passive voice!
					"PASSIVE_VOICE",
				},
			},
			checkFrequency = "manual",
		},
	},
	-- Expose checkDocument from ltex client
	-- Credits: https://github.com/vigoux/ltex-ls.nvim
	-- TODO(?): This should be removed on v2.x migration
	on_init = on_init,
}
