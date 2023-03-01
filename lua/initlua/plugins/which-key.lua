return {
	{
		"folke/which-key.nvim",
		opts = {
			layout = {
				height = { min = 4, max = 30 },
				width = { min = 30, max = 40 },
			},
			window = {
				border = initlua.global_settings.ui.border,
			},
		},
	},
}
