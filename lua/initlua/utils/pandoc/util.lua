initlua.pandoc.supported_extensions = { "md", "html" }

function initlua.pandoc.is_installed()
	return vim.fn.executable("pandoc") == 1
end

function initlua.pandoc.current_file_is_supported()
	local extension = vim.fn.expand("%:e")
	return vim.tbl_contains(initlua.pandoc.supported_extensions, extension)
end
