return {
	{
		"nguyenvukhang/nvim-toggler",
		event = "BufWinEnter",
		opts = {
			inverses = {
				["True"] = "False",
			},
		},
	},
}
