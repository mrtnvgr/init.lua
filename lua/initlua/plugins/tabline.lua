return {
    -- TODO: fix blinking
    "romgrk/barbar.nvim",
    lazy = false,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    opts = {
        animation = false,
        auto_hide = true,
        tabpages = false,
        icon_separator_active = "",
        icon_separator_inactive = "",
        icon_close_tab = "",
        icon_close_tab_modified = "●",
        icon_pinned = "車",
    },
}
