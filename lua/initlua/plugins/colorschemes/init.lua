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
-- CR05: Comments must be gray
-- TODO: CR99: Lualine must look like rose-pine's theme

M.colorschemes = {
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rose-pine/neovim", name = "rose-pine" },
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

local found = false
for i, value in ipairs(M.colorschemes) do
	if value.name == initlua.settings.colorscheme then
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
	vim.cmd.colorscheme(initlua.settings.colorscheme)
end

return M.colorschemes
