initlua.pandoc = {}

local modules = { "util", "compile", "types", "menu" }
for _, module in ipairs(modules) do
	require("initlua.utils.pandoc." .. module)
end
