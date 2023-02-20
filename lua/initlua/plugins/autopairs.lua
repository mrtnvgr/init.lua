return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
        },
        config = function()
            require("nvim-autopairs").setup()

            local status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
            local status2, cmp = pcall(require, "cmp")
            if status or status2 then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end,
    }
}
