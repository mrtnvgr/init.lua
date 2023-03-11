local M = {}

-- COLORSCHEME REFERENCE:
-- ================================================================================
-- This is a list of rules that every colorscheme in M.colorschemes list must obey.
-- On change, it is required to apply new change to the all colorschemes.
-- Rules are named like this "CF{NUMBER}".
-- Every rule in colorscheme setup should be commented.
-- ================================================================================
-- CR01: Background of floating windows must be transparent
-- CR02: Background of SignColumn must be linked to Normal background
-- CR03: Line numbers must be colored using only 1 monochrome color
-- CR04: Matching characted must be highlighted in completion menu
-- CR05: Comments must be grey
-- CR06: MsgArea and NoiceLspProgressTitle backgrounds must be linked to Normal background
-- CR07: Pmenu must have a uniform colors

M.colorschemes = {
	{ "folke/tokyonight.nvim", name = "tokyonight", names = { "tokyonight" } },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox", names = { "gruvbox" } },
	{ "catppuccin/nvim", name = "catppuccin", names = { "catppuccin" } },
	{ "rose-pine/neovim", name = "rose-pine", names = { "rose-pine" } },
	{ "Everblush/nvim", name = "everblush", names = { "everblush" } },
	{ "rebelot/kanagawa.nvim", name = "kanagawa", names = { "kanagawa-dragon", "kanagawa-wave" } },

	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		names = { "nightfox", "duskfox", "nordfox", "terafox", "carbonfox" },
	},
}

local function load(type, colorscheme)
	local settings = "initlua.plugins.colorschemes." .. type .. "." .. colorscheme
	package.loaded[settings] = nil
	return pcall(require, settings)
end

function M.load_settings(type, colorscheme)
	local ok, _ = load(type, colorscheme)
	if not ok then
		for _, value in ipairs(M.colorschemes) do
			if vim.tbl_contains(value.names, colorscheme) then
				load(type, value.name)
				break
			end
		end
	end
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

local found = false
for i, value in ipairs(M.colorschemes) do
	if value.name == initlua.settings.colorscheme or vim.tbl_contains(value.names, initlua.settings.colorscheme) then
		found = true
		-- Prioritize colorscheme
		M.colorschemes[i].lazy = false
		M.colorschemes[i].priority = 1000

		-- Add a config function if a plugin doesn't have it
		if value.config == nil then
			M.colorschemes[i].config = function()
				vim.cmd.colorscheme(initlua.settings.colorscheme)
			end
		end

		break
	end
end

-- Setup built-in colorscheme
if not found then
	pcall(vim.cmd.colorscheme, initlua.settings.colorscheme)
end

return M.colorschemes
