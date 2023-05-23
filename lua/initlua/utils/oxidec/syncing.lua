function initlua.oxidec.colorscheme.sync()
	if vim.fn.executable("oxidec") == 0 then
		initlua.err("oxidec is not installed!")
		return
	end

	if vim.g.terminal_color_0 == nil then
		initlua.err("vim.g.terminal_color_* are not set")
		return
	end

	local path = os.getenv("HOME") .. "/.cache/oxidec/status/colorscheme.json"
	local file = io.open(path, "r")
	if not file then
		initlua.oxidec.colorscheme.sync_with_current_one()
	else
		local cache = file:read("*a")
		file:close()

		local data = vim.json.decode(cache)
		if not data then
			initlua.err("oxidec: failed to parse status!")
			return
		end

		if data.name ~= initlua.settings.colorscheme then
			initlua.oxidec.colorscheme.sync_with_current_one()
		end
	end
end

function initlua.oxidec.colorscheme.sync_with_current_one()
	local Job = require("plenary.job")
	Job:new({
		command = "oxidec",
		args = { "colorscheme", "set", initlua.settings.colorscheme },
		on_exit = function(j, code)
			if code == 1 then
				initlua.err("oxidec: failed to set colorscheme!")
			else
				local result = table.concat(j:stderr_result(), "\n")
				if result:match("This colorscheme does not exist") then
					vim.schedule(initlua.oxidec.colorscheme.sync_using_terminal_colors)
					return
				end
			end
		end,
	}):start()
end

function initlua.oxidec.colorscheme.sync_using_terminal_colors()
	local file_path = os.getenv("HOME") .. "/.config/oxidec/colorschemes/" .. initlua.settings.colorscheme .. ".json"
	local file = io.open(file_path, "w")

	if not file then
		initlua.err("Failed to create a temporary file!")
		return
	end

	local normal = vim.api.nvim_get_hl_by_name("Normal", true)
	local bg = string.format("#%06x", normal["background"])
	local fg = string.format("#%06x", normal["foreground"])

	local schema = {
		special = {
			foreground = fg,
			background = bg,
			cursor = fg, -- FIXME: get cursor value
		},
		colors = {},
	}

	for i = 0, 15, 1 do
		local color = vim.api.nvim_get_var("terminal_color_" .. i)
		schema.colors["color" .. i] = color
	end

	file:write(vim.json.encode(schema))
	file:close()

	local Job = require("plenary.job")
	Job:new({
		command = "oxidec",
		args = { "colorscheme", "set", initlua.settings.colorscheme },
		on_exit = function(_, code)
			if code ~= 0 then
				initlua.err("oxidec: failed to import a colorscheme")
				os.remove(file_path)
			end
		end,
	}):start()
end
