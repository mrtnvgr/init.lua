initlua.cache = {}

-- Using this instead of plenary.nvim, because plugins are loaded later.
local path_sep = "/"
if vim.fn.has("win32") == 1 then
	path_sep = "\\"
end

initlua.cache.path = initlua.install_path .. path_sep .. "cache.json"

function initlua.cache.get()
	local file = io.open(initlua.cache.path, "r")
	if not file then
		return initlua.settings
	else
		local cache = file:read("*a")
		file:close()
		return vim.json.decode(cache)
	end
end

function initlua.cache.load()
	local cache = initlua.cache.get()
	if cache ~= initlua.settings then
		initlua.settings = vim.tbl_deep_extend("force", initlua.settings, cache)
	end
end

function initlua.cache.save()
	local file = io.open(initlua.cache.path, "w")
	if file then
		local encoded = vim.json.encode(initlua.settings)
		file:write(encoded)
		file:close()
	else
		initlua.err("Failed to save cache file!")
	end
end

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	desc = "Save settings file",
	callback = function()
		initlua.cache.save()
	end,
})

vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
	desc = "Save colorscheme name to settings",
	callback = function()
		initlua.settings.colorscheme = vim.fn.expand("<amatch>")
	end,
})

initlua.cache.load()
