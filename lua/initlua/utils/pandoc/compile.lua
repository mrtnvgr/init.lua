function initlua.pandoc.compile(output_extension, output_format, args, success_callback)
	if not initlua.pandoc.is_installed() then
		initlua.err("pandoc is not installed on your system")
		return
	end

	if not initlua.pandoc.current_file_is_supported() then
		local extension = vim.fn.expand("%:e")
		initlua.err("pandoc: can't convert " .. extension .. " file to pdf")
		return
	end

	local Job = require("plenary.job")
	local input = vim.fn.expand("%:p")
	local output = vim.fn.expand("%:p:r") .. "." .. output_extension

	local errs = {}

	local cwd = require("plenary.path"):new(initlua.install_path, "pandoc", "themes")

	Job:new({
		command = "pandoc",
		args = { input, "--resource-path=" .. vim.fn.expand("%:p:h"), "-t", output_format, "-o", output, unpack(args) },
		cwd = cwd.filename,

		on_start = function()
			initlua.notify("pandoc: compiling...")
		end,

		on_exit = function(_, code)
			if code ~= 0 then
				initlua.err("pandoc: failed to compile this document using " .. output_format .. ".")
				initlua.err(table.concat(errs, "\n"))
				return
			end

			initlua.notify("pandoc: compiled successfully!")
			success_callback(output)
		end,

		on_stderr = function(_, err)
			table.insert(errs, err)
		end,
	}):start()
end
