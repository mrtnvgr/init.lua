return {
	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		name = "tokyonight",
		config = function()
			require("tokyonight").setup({ style = "night" })
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		name = "gruvbox",
	},

	-- Catppuccin
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},
}
