initlua.pandoc = {}

local settings = {
	pdf = {
		themes = { "metropolis", "SimplePlus" },
	},
}

if not initlua.settings.pandoc then
	initlua.settings.pandoc = {}
end

vim.tbl_deep_extend("force", settings, initlua.settings.pandoc)
table.sort(initlua.settings.pandoc.pdf.themes)

local modules = { "util", "compile", "types", "menu" }
for _, module in ipairs(modules) do
	require("initlua.utils.pandoc." .. module)
end
