local cmd = vim.cmd

-- Do not comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

cmd ([[
	command! W :w
	command! Q :q
]])

vim.api.nvim_create_autocmd("User", {
    desc = "Reload options after lazy sync",
    pattern = "LazySync",
    callback = function()
        vim.cmd.InitLuaReload()
    end,
})
