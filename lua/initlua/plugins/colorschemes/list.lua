-- COLORSCHEME REFERENCE:
-- ================================================================================
-- This is a list of rules that every colorscheme in M.colorschemes list must obey.
-- On change, it is required to apply new change to the all colorschemes.
-- Rules are named like this "CF{NUMBER}".
-- Every rule in colorscheme setup should be commented.
-- ================================================================================
-- CR01: Background of floating windows must be transparent
--		 (NormalFloat, NotifyBackground, WhichKeyFloat, Pmenu, PmenuSbar)
-- CR02: Background of SignColumn must be linked to Normal background
-- CR03: Line numbers must be colored using only 1 monochrome color
-- CR04: Matching characted must be highlighted in completion menu
-- CR05: Comments must be grey
-- CR06: MsgArea and NoiceLspProgressTitle backgrounds must be linked to Normal background
-- CR07: Pmenu must have uniform colors
-- CR08: Cursor must be colored exactly like a terminal cursor

return {
	{ "folke/tokyonight.nvim", name = "tokyonight", names = { "tokyonight" } },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox", names = { "gruvbox" } },
	{ "catppuccin/nvim", name = "catppuccin", names = { "catppuccin" } },
	{ "rose-pine/neovim", name = "rose-pine", names = { "rose-pine" } },
	{ "Everblush/nvim", name = "everblush", names = { "everblush" } },
	{ "rebelot/kanagawa.nvim", name = "kanagawa", names = { "kanagawa-dragon", "kanagawa-wave" } },
	{ "gbprod/nord.nvim", name = "nord", names = { "nord" } },
	{ "Yazeed1s/minimal.nvim", name = "minimal", names = { "minimal-base16", "minimal" } },

	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		names = { "nightfox", "duskfox", "nordfox", "terafox", "carbonfox" },
	},
	-- TODO: solarized
}
