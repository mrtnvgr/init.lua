initlua.pandoc.types = {}

local types = { "presentation", "essay" }
for _, module in ipairs(types) do
	require("initlua.utils.pandoc.types." .. module)
end
