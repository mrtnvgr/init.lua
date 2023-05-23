initlua.oxidec.colorscheme = {}

function initlua.oxidec.colorscheme.set_from_cache()
	local path = os.getenv("HOME") .. "/.cache/oxidec/status/colorscheme.json"
	local file = io.open(path, "r")

	if not file then
		initlua.err("oxidec: failed to get colorscheme status")
		return
	end

	local cache = file:read("*a")
	file:close()

	local data = vim.json.decode(cache)
	if not data then
		initlua.err("oxidec: failed to parse colorscheme status!")
		return
	end

	pcall(vim.cmd.colorscheme, data.name)
end
