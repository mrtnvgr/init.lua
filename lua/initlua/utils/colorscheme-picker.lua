function initlua.select_colorscheme()
	package.loaded["initlua.plugins.colorschemes"] = nil
	local colorschemes = require("initlua.plugins.colorschemes")
	for i, value in ipairs(colorschemes) do
		colorschemes[i] = value.name
	end

	vim.ui.select(colorschemes, { prompt = "Select colorscheme" }, function(selected)
		if selected ~= nil then
			vim.cmd.colorscheme(selected)
			initlua.settings.colorscheme = selected
		end
	end)
end

vim.api.nvim_create_user_command(
	"InitluaSelectColorscheme",
	initlua.select_colorscheme,
	{ desc = "Select colorscheme" }
)
