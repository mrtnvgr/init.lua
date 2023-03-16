initlua.format = {}

function initlua.format.toggle()
	local f = require("lsp-format")
	f.toggle({ args = "" })
	if f.disabled then
		initlua.notify("Null-ls formatting was disabled")
	else
		initlua.notify("Null-ls formatting was enabled")
	end
end

vim.api.nvim_create_user_command(
	"InitluaToggleFormatting",
	initlua.format.toggle,
	{ desc = "Toggle null-ls formatting" }
)
vim.keymap.set("n", "<leader>atf", initlua.format.toggle)
