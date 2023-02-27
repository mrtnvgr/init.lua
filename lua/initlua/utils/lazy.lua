initlua.lazy = {}

function initlua.lazy.update()
	require("lazy.core.plugin").load()

	vim.api.nvim_create_autocmd("User", {
		once = true,
		desc = "Close Lazy window after update",
		pattern = "LazySync",
		callback = function()
			local has_updates = require("lazy.status").has_updates
			if not has_updates then
				-- TODO: https://github.com/folke/lazy.nvim/issues/578
				require("lazy.view").close()
			end
		end,
	})

	require("lazy").sync({ wait = true })
end