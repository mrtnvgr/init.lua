initlua.pandoc = {
	supported_extensions = { "md" },
}

function initlua.pandoc.is_installed()
	return vim.fn.executable("pandoc") == 1
end

function initlua.pandoc.current_file_is_supported()
	local extension = vim.fn.expand("%:e")
	return vim.tbl_contains(initlua.pandoc.supported_extensions, extension)
end

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

	Job:new({
		command = "pandoc",
		args = { input, "-t", output_format, "-o", output, unpack(args) },
		-- cwd = initlua.install_path .. sep .. "pandoc",
		on_exit = function(_, code)
			if code ~= 0 then
				initlua.err("pandoc: failed to compile this document using " .. output_format .. ".")
			else
				initlua.notify("pandoc: compiled successfully!")
				success_callback(output)
			end
		end,
		on_stderr = function(_, err)
			initlua.err("pandoc: " .. err)
		end,
	}):start()
end

function initlua.pandoc.compile_pdf()
	initlua.pandoc.compile("pdf", "beamer", { "-V", "colortheme:metropolis" }, function(output)
		if vim.fn.executable("zathura") then
			return
		end

		local Job = require("plenary.job")
		Job:new({ command = "zathura", args = { output } }):start()
	end)
end
