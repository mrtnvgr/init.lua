return {
	{
		"rcarriga/nvim-notify",
		event = { "VimEnter" },
		opts = {
			fps = 144,
			timeout = 2500,
			stages = "fade",
		},
	},

	{
		"stevearc/dressing.nvim",
		event = "VimEnter",
		opts = {
			input = { border = initlua.settings.ui.border },
			select = {
				nui = {
					border = { style = initlua.settings.ui.border },
				},
				builtin = {
					border = initlua.settings.ui.border,
				},
			},
		},
	},
}
