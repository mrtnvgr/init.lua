local M = {}

local default_colorscheme = "tokyonight"

local colorschemes = {
	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
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

function M.load_settings(type, colorscheme)
	local settings = "initlua.plugins.colorschemes." .. type .. "." .. colorscheme
	package.loaded[settings] = nil
	pcall(require, settings)
end

vim.api.nvim_create_autocmd("ColorSchemePre", {
	callback = function()
		M.load_settings("pre", vim.fn.expand("<amatch>"))
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		M.load_settings("post", vim.fn.expand("<amatch>"))
	end,
})

for i, value in ipairs(colorschemes) do
	if value.name == default_colorscheme then
		-- Prioritize colorscheme
		colorschemes[i].lazy = false
		colorschemes[i].priority = 1000

		-- Add a config function if a plugin doesn't have it
		if value.config == nil then
			colorschemes[i].config = function()
				vim.cmd.colorscheme(default_colorscheme)
			end
		end

		break
	end
end

return colorschemes
