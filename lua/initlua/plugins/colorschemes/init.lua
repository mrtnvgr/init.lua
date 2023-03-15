local M = {}

M.colorschemes = require("initlua.plugins.colorschemes.list")

local function load(type, colorscheme)
	local settings = "initlua.plugins.colorschemes." .. type .. "." .. colorscheme
	package.loaded[settings] = nil
	return pcall(require, settings)
end

function M.load_settings(type, colorscheme)
	local ok, _ = load(type, colorscheme)
	if not ok then
		for _, value in ipairs(M.colorschemes) do
			if vim.tbl_contains(value.names, colorscheme) then
				load(type, value.name)
				break
			end
		end
	end
end

function M.prioritize_colorscheme(name)
	local found = false
	for i, value in ipairs(M.colorschemes) do
		if value.name == name or vim.tbl_contains(value.names, name) then
			found = true
			-- Prioritize colorscheme
			M.colorschemes[i].lazy = false
			M.colorschemes[i].priority = 1000

			-- Add a config function if a plugin doesn't have it
			if value.config == nil then
				M.colorschemes[i].config = function()
					vim.cmd.colorscheme(name)
				end
			end

			break
		end
	end
	return found
end

vim.api.nvim_create_autocmd("ColorSchemePre", {
	group = "Initlua",
	callback = function()
		M.load_settings("pre", vim.fn.expand("<amatch>"))
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = "Initlua",
	callback = function()
		M.load_settings("post", vim.fn.expand("<amatch>"))
		initlua.cs.sync()
	end,
})

local found = M.prioritize_colorscheme(initlua.settings.colorscheme)

-- Setup built-in colorscheme
if not found then
	local ok, _ = pcall(vim.cmd.colorscheme, initlua.settings.colorscheme)

	-- Set a random colorscheme if saved one wasn't found
	if not ok then
		initlua.colorscheme.set_random(false)
		M.prioritize_colorscheme(initlua.settings.colorscheme)
	end
end

return M.colorschemes
