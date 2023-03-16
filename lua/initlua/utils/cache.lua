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
	local Job = require("plenary.job")
	local encoded = vim.json.encode(initlua.settings)
	if not encoded then
		return
	end

	local get_result = function(j, code)
		if code == 1 then
			return
		end
		encoded = table.concat(j:result(), "\n")
	end

	-- Prettify json using external tools
	if vim.fn.executable("jq") then
		Job:new({
			command = "jq",
			args = { "." },
			writer = encoded,
			on_exit = get_result,
		}):sync()
	elseif vim.fn.has("python") then
		Job:new({
			command = "python",
			args = { "-m", "json.tool" },
			writer = encoded,
			on_exit = get_result,
		}):sync()
	end

	local file = io.open(initlua.cache.path, "w")
	if file then
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
