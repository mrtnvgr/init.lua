return {
	"Wansmer/langmapper.nvim",
	event = "VeryLazy",
	config = function()
		local langmapper = require("langmapper")
		langmapper.setup()
		langmapper.hack_get_keymap()
	end,
}
