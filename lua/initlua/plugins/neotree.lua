return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = { "Neotree" },
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			popup_border_style = initlua.settings.ui.border,
			buffers = {
				show_unloaded = false,
			},
		},
	},
}
