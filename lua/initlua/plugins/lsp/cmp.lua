local M = {}

function M.setup()
	local lsp = require("initlua.plugins.lsp.core")

	local cmp = require("cmp")

	local cmp_config = lsp.defaults.cmp_config({
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		window = {
			completion = cmp.config.window.bordered({ border = initlua.settings.ui.border }),
			documentation = cmp.config.window.bordered({ border = initlua.settings.ui.border }),
		},
		preselect = "none",
		completion = { completeopt = "menu,menuone,noinsert,noselect" },
	})

	cmp.setup(cmp_config)
end

return M
