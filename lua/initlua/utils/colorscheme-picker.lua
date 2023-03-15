function initlua.select_colorscheme()
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
			initlua.cs.sync()
		end
	end)
end

vim.api.nvim_create_user_command(
	"InitluaSelectColorscheme",
	initlua.select_colorscheme,
	{ desc = "Select colorscheme" }
)
