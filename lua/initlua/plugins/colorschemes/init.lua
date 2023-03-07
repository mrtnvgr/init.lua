local M = {}

M.colorschemes = {
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

	-- Rose pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
}

function M.load_settings(type, colorscheme)
	local settings = "initlua.plugins.colorschemes." .. type .. "." .. colorscheme
	package.loaded[settings] = nil
	pcall(require, settings)
end

vim.api.nvim_create_autocmd("ColorSchemePre", {
	group = "Initlua",
	callback = function()
		M.load_settings("pre", vim.fn.expand("<amatch>"))
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = "Initlua",
	callback = function()
		M.load_settings("post", vim.fn.expand("<amatch>"))
	end,
})

for i, value in ipairs(M.colorschemes) do
	if value.name == initlua.global_settings.default_colorscheme then
		-- Prioritize colorscheme
		M.colorschemes[i].lazy = false
		M.colorschemes[i].priority = 1000

		-- Add a config function if a plugin doesn't have it
		if value.config == nil then
			M.colorschemes[i].config = function()
				vim.cmd.colorscheme(initlua.global_settings.default_colorscheme)
			end
		end

		break
	end
end

return M.colorschemes
