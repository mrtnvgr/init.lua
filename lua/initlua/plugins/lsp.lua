return {
    {
        "VonHeikemen/lsp-zero.nvim",
        event = "VeryLazy",
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
            {"f3fora/cmp-spell"},
            {"lukas-reineke/cmp-under-comparator"},
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

            -- local cmp = require("cmp")
            --
            -- lsp.setup_nvim_cmp({
            --     sources = {
            --         { name = "spell" },
            --     },
            --
            --     sorting = {
            --         comparators = {
            --             cmp.config.compare.offset,
            --             cmp.config.compare.exact,
            --             cmp.config.compare.score,
            --             require("cmp-under-comparator").under,
            --             cmp.config.compare.kind,
            --             cmp.config.compare.sort_text,
            --             cmp.config.compare.length,
            --             cmp.config.compare.order,
            --         },
            --     },
            -- })

            lsp.setup()
        end,
    },
}
