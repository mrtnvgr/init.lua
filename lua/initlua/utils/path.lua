initlua.path = {}

initlua.path.config = vim.fn.stdpath("config")

initlua.path.sep = "/"
if vim.fn.has("win32") == 1 then
	initlua.path.sep = "\\"
end

function initlua.path.exists(path)
	if type(path) == "table" then
		path = table.concat(path, initlua.path.sep)
	end

	local file = io.open(path, "r")
	if file ~= nil then
		io.close(file)
		return true
	else
		return false
	end
end
