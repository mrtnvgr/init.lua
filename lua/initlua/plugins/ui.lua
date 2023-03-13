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
		config = function()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "DressingSelect",
				callback = function(args)
					vim.keymap.set("n", "<Tab>", "j", { buffer = args.buf })
				end,
			})

			require("dressing").setup({
				input = { border = initlua.settings.ui.border },
				select = {
					nui = {
						border = { style = initlua.settings.ui.border },
					},
					builtin = {
						border = initlua.settings.ui.border,
					},
				},
			})
		end
	},
}
