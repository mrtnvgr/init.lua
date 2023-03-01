local M = {}

local lsp = require("initlua.plugins.lsp.core")

-- TODO: this does not need to be hardcoded
-- use: "return {}" for no configuration
M.ensure_installed = {
	"pyright", -- Python
	"lua_ls", -- Lua
	"jsonls", -- JSON
	"yamlls", -- YAML
	"taplo", -- TOML
	"ltex", -- Language
}

lsp.ensure_installed(M.ensure_installed)

for _, server in ipairs(M.ensure_installed) do
	local path = "initlua.plugins.lsp.servers." .. server
	local ok, settings = pcall(require, path)
	if ok then
		lsp.configure(server, settings)
	else
		-- WARN: remove on release
		initlua.notify(server .. " failed!")
	end
end
