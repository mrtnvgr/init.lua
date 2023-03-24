_G.initlua = {}
local stdpath = vim.fn.stdpath

initlua.settings = {
	ui = {
		border = "single",
	},
	colorscheme = "rose-pine",
	_internals = {
		update_available = false,
	},
}

initlua.install_path = stdpath("config")

function initlua.notify(msg, type, opts)
	local default_opts = { title = "Init.lua" }
	if opts then
		opts = vim.tbl_deep_extend("force", default_opts, opts)
	else
		opts = default_opts
	end

	vim.schedule(function()
		vim.notify(msg, type, opts)
	end)
end

function initlua.err(msg)
	initlua.notify(msg, "error")
end

function initlua.set_sign(name, text, ...)
	return vim.fn.sign_define(name, { texthl = name, text = text, ... })
end

local modules = {
	-- General utils
	"cache",
	"configure",

	-- Required for updating
	"mason",
	"updater",

	-- Miscellaneous
	"format",
	"colorscheme",
	"cs",
	"pandoc",
}

for _, module in ipairs(modules) do
	require("initlua.utils" .. "." .. module)
end
