initlua.oxidec.wallpaper = {}

function initlua.oxidec.wallpaper.set_random()
	if vim.fn.executable("oxidec") == 0 then
		initlua.err("oxidec is not installed!")
		return
	end

	local Job = require("plenary.job")
	Job:new({
		command = "oxidec",
		args = { "wallpaper", "set" },
	}):start()
end

vim.api.nvim_create_user_command(
	"OxidecRandomWallpaper",
	initlua.oxidec.wallpaper.set_random,
	{ desc = "Set a random wallpaper" }
)
vim.keymap.set("n", "<leader>arw", initlua.oxidec.wallpaper.set_random)
