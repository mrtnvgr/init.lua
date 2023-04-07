return {
	settings = {
		Lua = {
			-- using null-ls formatting instead
			format = { enable = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}
