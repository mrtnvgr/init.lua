local status, lualine = pcall(require, "lualine")
if not status then
    return
end

lualine.setup({
    options = {
        section_separators = "",
        component_separators = "",
    },
    refresh = {
        statusline = vim.opt.updatetime,
    },
})

lualine.hide({
    place = {"tabline"},
    unhide = false,
})
