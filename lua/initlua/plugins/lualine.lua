local function lualine_setup()
	local lualine = require("lualine")

	local custom_auto = require("lualine.themes.auto")
	custom_auto.normal.c.bg = "NONE"

	lualine.setup({
		options = {
			theme = custom_auto,
			section_separators = "",
			component_separators = "",
		},
		refresh = {
			statusline = vim.opt.updatetime,
		},
	})

	lualine.hide({
		place = { "tabline" },
		unhide = false,
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		lualine_setup()

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = "lualine",
			callback = lualine_setup,
		})

		vim.api.nvim_create_autocmd("OptionSet", {
			group = "lualine",
			pattern = "background",
			callback = lualine_setup,
		})
	end,
}
