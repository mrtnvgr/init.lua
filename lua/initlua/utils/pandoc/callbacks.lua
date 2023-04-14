initlua.pandoc.callbacks = {}

function initlua.pandoc.callbacks.run(name, output, job_args)
	if vim.fn.executable(name) == 0 then
		return
	end

	local args = { command = name, args = { output } }
	if job_args then
		args = vim.tbl_deep_extend("force", args, job_args)
	end

	local Job = require("plenary.job")
	Job:new(args):start()
end

function initlua.pandoc.callbacks.office(output)
	initlua.pandoc.callbacks.run("libreoffice", output)
end
