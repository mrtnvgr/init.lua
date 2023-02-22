return {
    {
        "VonHeikemen/lsp-zero.nvim",
        event = "VeryLazy",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "f3fora/cmp-spell" },
            { "lukas-reineke/cmp-under-comparator" },
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional

            -- Null-ls
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero").preset({
                name = "recommended",
                set_lsp_keymaps = true,
                manage_nvim_cmp = false,
                suggest_lsp_servers = true,
            })

            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr }
                local bind = vim.keymap.set

                bind("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
            end)

            lsp.setup()

            local cmp_sources = lsp.defaults.cmp_sources()
            table.insert(cmp_sources, { name = "spell" })

            local cmp = require("cmp")

            local cmp_config = lsp.defaults.cmp_config({
                sources = cmp_sources,
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
                window = { completion = cmp.config.window.bordered() },
                preselect = "none",
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
            })

            -- lsp.configure("pyright", {
            --     settings = {
            --         python = {
            --             -- Turn off type checking
            --             analysis = { diagnosticSeverityOverrides = { reportGeneralTypeIssues = "none" } },
            --         },
            --     }
            -- })

            lsp.setup_servers({
                "jedi_language_server", -- Python
                "lua_ls", -- Lua
            })

            lsp.nvim_workspace()

            cmp.setup(cmp_config)

            -- null-ls setup
            local null_ls = require("null-ls")
            local null_opts = lsp.build_options("null-ls", {})

            null_ls.setup({
                on_attach = function(client, bufnr)
                    null_opts.on_attach(client, bufnr)

                    local format_cmd = function(input)
                        vim.lsp.buf.format({
                            id = client.id,
                            timeout_ms = 5000,
                            async = input.bang,
                        })
                    end

                    local bufcmd = vim.api.nvim_buf_create_user_command
                    bufcmd(bufnr, "NullFormat", format_cmd, {
                        bang = true,
                        range = true,
                        desc = "Format using null-ls"
                    })
                end,
                sources = {}
            })

            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true,
                automatic_setup = true,
            })

            require("mason-null-ls").setup_handlers()
        end,
    },
}
