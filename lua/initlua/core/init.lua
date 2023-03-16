local modules = {
	"autocmds",
	"options",
	"keymaps",
}

for _, module in pairs(modules) do
	require("initlua.core." .. module)
end
