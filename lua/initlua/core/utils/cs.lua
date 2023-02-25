initlua.cs = {}

function initlua.cs.exists()
	return vim.fn.executable("cs") == 1
end

function initlua.cs.set(colorscheme)
	local colorschemes = {
		-- HACK: optimise
		colorscheme,
		colorscheme:gsub("-", "_"),
		colorscheme:gsub("_", "-"),
		colorscheme:gsub("-.*", ""),
		colorscheme:gsub("_.*", ""),
	}
	-- TODO: use "find" command to search, and set using this
	for _, gsubbed_colorscheme in pairs(colorschemes) do
		local Job = require("plenary.job")
		Job:new({
			command = "cs",
			args = {
				"set",
				gsubbed_colorscheme,
			},
		}):sync()
	end
end
