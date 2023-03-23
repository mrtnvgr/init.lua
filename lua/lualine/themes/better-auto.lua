package.loaded["lualine.themes.auto"] = nil
local auto = require("lualine.themes.auto")

for key, value in pairs(auto) do
	if value.c ~= nil and value.c.bg ~= nil then
		auto[key].c.bg = "NONE"
	end
end
auto.normal.c.bg = "NONE"

return auto
