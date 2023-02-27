local default_colorscheme = "tokyonight"

local colorschemes = {
	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		config = function()
			require("tokyonight").setup({
				style = "night",
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
	},

	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
}

for i, value in ipairs(colorschemes) do
	if value.name == default_colorscheme then
		-- Prioritize colorscheme
		colorschemes[i].lazy = false
		colorschemes[i].priority = 1000

		-- Make config function if none
		if value.config == nil then
			colorschemes[i].config = function()
				vim.cmd.colorscheme(default_colorscheme)
			end
		end

		break
	end
end

return colorschemes
