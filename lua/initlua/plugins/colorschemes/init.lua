local M = {}

M.colorschemes = {
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rose-pine/neovim", name = "rose-pine" },
}

function M.load_settings(type, colorscheme)
	local settings = "initlua.plugins.colorschemes." .. type .. "." .. colorscheme
	package.loaded[settings] = nil
	pcall(require, settings)
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
	end,
})

local found = false
for i, value in ipairs(M.colorschemes) do
	if value.name == initlua.settings.colorscheme then
		found = true
		-- Prioritize colorscheme
		M.colorschemes[i].lazy = false
		M.colorschemes[i].priority = 1000

		-- Add a config function if a plugin doesn't have it
		if value.config == nil then
			M.colorschemes[i].config = function()
				vim.cmd.colorscheme(initlua.settings.colorscheme)
			end
		end

		break
	end
end

-- Setup built-in colorscheme
if not found then
	vim.cmd.colorscheme(initlua.settings.colorscheme)
end

return M.colorschemes
