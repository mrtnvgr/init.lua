return {
	-- Split/Join blocks of code
	{
		"Wansmer/treesj",
		event = "BufEnter",
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
}
