initlua.oxidec = {}

local modules = {
	"selectors",

	"colorscheme",
	"wallpaper",
	"theme",

	"syncing",
}

for _, module in ipairs(modules) do
	require("initlua.utils.oxidec" .. "." .. module)
end
