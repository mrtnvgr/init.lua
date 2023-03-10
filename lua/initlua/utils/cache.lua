initlua.cache = {}

-- Using this instead of plenary.nvim, because plugins are loaded later.
local is_win = vim.fn.has("win32")
local path_sep = "/"
if is_win then
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
	initlua.settings = vim.tbl_deep_extend("force", initlua.settings, cache)
end

function initlua.cache.save()
	local saved_settings = initlua.cache.get()
	-- TODO: move to initlua module
	local do_tables_match = function(a, b)
		return table.concat(a) == table.concat(b)
	end

	if not do_tables_match(saved_settings, initlua.settings) then
		local file = io.open(initlua.cache.path, "w")
		if file then
			local encoded = vim.json.encode(initlua.settings)
			file:write(encoded)
			file:close()
		else
			initlua.err("Failed to save cache file!")
		end
	end
end

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	desc = "Save settings file",
	callback = function()
		initlua.cache.save()
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	desc = "Save colorscheme name to settings",
	callback = function()
		initlua.settings.colorscheme = vim.fn.expand("<amatch>")
	end,
})

initlua.cache.load()
