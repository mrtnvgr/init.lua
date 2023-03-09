initlua.cache = {}
-- TODO: on windows this will fail
initlua.cache.path = initlua.install_path .. "/" .. "cache.json"

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
	desc = "Save settings to cache file",
	callback = function()
		initlua.cache.save()
	end,
})

initlua.cache.load()
