initlua.colorscheme = {}

function initlua.colorscheme.select()
	package.loaded["initlua.plugins.colorschemes.list"] = nil
	local colorscheme_tables = require("initlua.plugins.colorschemes.list")
	local colorschemes = {}
	for _, value in ipairs(colorscheme_tables) do
		for _, colorscheme in ipairs(value.names) do
			table.insert(colorschemes, colorscheme)
		end
	end

	table.sort(colorschemes)

	vim.ui.select(colorschemes, { prompt = "Select colorscheme" }, function(selected)
		if selected ~= nil then
			vim.cmd.colorscheme(selected)
			vim.schedule(initlua.oxidec.sync)
		end
	end)
end

function initlua.colorscheme.set_random(cache_only)
	math.randomseed(os.clock() * os.clock())

	package.loaded["initlua.plugins.colorschemes.list"] = nil
	local colorschemes = require("initlua.plugins.colorschemes.list")

	colorschemes = vim.tbl_map(function(tbl)
		return tbl.names
	end, colorschemes)
	colorschemes = vim.tbl_flatten(colorschemes)

	local colorscheme = colorschemes[math.random(#colorschemes)]

	initlua.settings.colorscheme = colorscheme

	if not cache_only then
		pcall(vim.cmd.colorscheme, initlua.settings.colorscheme)
		vim.schedule(initlua.oxidec.sync)
	end
end

vim.api.nvim_create_user_command(
	"InitluaSelectColorscheme",
	initlua.colorscheme.select,
	{ desc = "Select colorscheme" }
)
vim.keymap.set("n", "<leader>asc", initlua.colorscheme.select)

vim.api.nvim_create_user_command(
	"InitluaRandomColorscheme",
	initlua.colorscheme.set_random,
	{ desc = "Set a random colorscheme" }
)
vim.keymap.set("n", "<leader>arc", initlua.colorscheme.set_random)
