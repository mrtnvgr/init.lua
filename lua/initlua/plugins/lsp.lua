return {
    {
		"VonHeikemen/lsp-zero.nvim",
        event = "BufReadPost",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{"neovim/nvim-lspconfig"},             -- Required
			{"williamboman/mason.nvim"},           -- Optional
			{"williamboman/mason-lspconfig.nvim"}, -- Optional

			-- Autocompletion
			{"hrsh7th/nvim-cmp"},         -- Required
			{"hrsh7th/cmp-nvim-lsp"},     -- Required
			{"hrsh7th/cmp-buffer"},       -- Optional
			{"hrsh7th/cmp-path"},         -- Optional
			{"saadparwaiz1/cmp_luasnip"}, -- Optional
			{"hrsh7th/cmp-nvim-lua"},     -- Optional

			-- Snippets
			{"L3MON4D3/LuaSnip"},             -- Required
			{"rafamadriz/friendly-snippets"}, -- Optional
		},
        config = function()
            local lsp = require("lsp-zero").preset({
                name = "minimal",
                set_lsp_keymaps = true,
                manage_nvim_cmp = true,
                suggest_lsp_servers = true,
            })

            lsp.on_attach(function(_, bufnr)
                local opts = {buffer = bufnr}
                local bind = vim.keymap.set

                bind("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
            end)

            lsp.nvim_workspace()
            lsp.setup()
        end,
	},
}
