initlua.cs = {}

function initlua.cs.sync()
	if vim.fn.has("win32") == 1 then
		return
	end

	if vim.fn.executable("cs") == 0 then
		return
	end

	if vim.g.terminal_color_0 == nil then
		return
	end

	if initlua.cs.check_colorscheme() then
		return
	end

	if not initlua.cs.sync_using_existing_colorscheme() then
		initlua.cs.sync_using_terminal_colors()
	end
end

function initlua.cs.check_colorscheme()
	local file = io.popen("cs status", "r")
	file:flush()
	local data = vim.json.decode(file:read("*a"))
	file:close()
	if data.colorscheme.name == initlua.settings.colorscheme then
		return true
	end
end

function initlua.cs.sync_using_existing_colorscheme()
	local file = io.popen("cs set " .. initlua.settings.colorscheme, "r")
	file:flush()
	if not file:read("*a"):match("error: Unknown colorscheme: ") then
		return true
	end
	file:close()
end

function initlua.cs.sync_using_terminal_colors()
	local file_path = "/tmp/" .. initlua.settings.colorscheme .. ".xresources"
	local file = io.open(file_path, "w")

	if not file then
		initlua.err("Failed to create a temporary file!")
	end

	-- Write 0-15 colors
	for i = 0, 15, 1 do
		local color = vim.api.nvim_get_var("terminal_color_" .. i)
		file:write("\n*.color" .. i .. ": " .. color)
		file:write("\n*color" .. i .. ": " .. color)
	end

	-- Get background and foreground from Normal highlight group
	local normal = vim.api.nvim_get_hl_by_name("Normal", true)
	local bg = string.format("#%06x", normal["background"])
	local fg = string.format("#%06x", normal["foreground"])

	-- Write special colors
	local special_colors = {
		foreground = fg,
		background = bg,
		color66 = vim.g.terminal_color_0,
		["slock.init"] = vim.g.terminal_color_0,
		["slock.input"] = vim.g.terminal_color_4,
		["slock.failed"] = vim.g.terminal_color_1,
	}
	for key, value in pairs(special_colors) do
		if not key:find("%.") then
			file:write("\n*." .. key .. ": " .. value)
			file:write("\n*" .. key .. ": " .. value)
		else
			file:write("\n" .. key .. ": " .. value)
		end
	end

	file:close()

	io.popen("cs import " .. file_path, "r")
	initlua.cs.sync_using_existing_colorscheme()

	return true
end
