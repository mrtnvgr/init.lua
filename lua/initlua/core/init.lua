local modules = {
	"autocmds",
	"options",
	"keymaps",
}

for _, module in pairs(modules) do
	local ok, _ = pcall(require, "initlua.core.lua." .. module)

	if not ok then
		require(module)
	end
end
