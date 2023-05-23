initlua.oxidec.theme = {}

function initlua.oxidec.theme.set_random()
	if vim.fn.executable("oxidec") == 0 then
		initlua.err("oxidec is not installed!")
		return
	end

	local Job = require("plenary.job")
	Job:new({
		command = "oxidec",
		args = { "theme", "set" },
	}):sync()

	initlua.oxidec.colorscheme.set_from_cache()
end

vim.api.nvim_create_user_command("OxidecRandomTheme", initlua.oxidec.theme.set_random, { desc = "set random theme" })
vim.keymap.set("n", "<leader>art", initlua.oxidec.theme.set_random)
