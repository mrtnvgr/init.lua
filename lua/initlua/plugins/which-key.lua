return {
    {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
				layout = {
					height = { min = 4, max = 30 },
					width = { min = 30, max = 40 }
				},
				window = {
					border = "single",
				}
			}
		end
	},
}
