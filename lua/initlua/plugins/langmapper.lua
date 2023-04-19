return {
	"Wansmer/langmapper.nvim",
	event = "VeryLazy",
	config = function()
		require("langmapper").setup()

		require("leap.util")["get-input"] = function()
			local ok, ch = pcall(vim.fn.getcharstr)
			if ok and ch ~= vim.api.nvim_replace_termcodes("<esc>", true, false, true) then
				return require("langmapper.utils").translate_keycode(ch, "default", "ru")
			end
		end
	end,
}
