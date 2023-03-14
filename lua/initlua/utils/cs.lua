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

	local Job = require("plenary.job")
	Job:new({
		command = "cs",
		args = { "status" },
		on_exit = function(j, code)
			if code == 1 then
				initlua.err("Failed to get cs status!")
				return
			end

			local result = table.concat(j:result(), "\n")
			local data = vim.json.decode(result)
			if not data then
				initlua.err("Failed to parse cs status!")
				return
			end

			if data.colorscheme.name ~= initlua.settings.colorscheme then
				initlua.cs.set_existing_colorscheme()
			end
		end,
	}):start()
end

function initlua.cs.set_existing_colorscheme()
	local Job = require("plenary.job")
	Job:new({
		command = "cs",
		args = { "set", initlua.settings.colorscheme },
		on_exit = function(j, code)
			local result = table.concat(j:result(), "\n")
			if result:match("Unknown colorscheme: ") then
				vim.schedule(initlua.cs.sync_using_terminal_colors)
				return
			end

			if code == 1 then
				initlua.err("Failed to set cs colorscheme!")
			end
		end,
	}):start()
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

	local Job = require("plenary.job")
	Job:new({
		command = "cs",
		args = { "import", file_path },
		on_exit = function(_, code)
			if code == 0 then
				initlua.cs.set_existing_colorscheme()
			end
		end,
	}):start()
end
