local create_command = vim.api.nvim_create_user_command

create_command("InitLuaReload", function()

    for name, _ in pairs(package.loaded) do
        if name:match("^initlua") then
            package.loaded[name] = nil
        end

        dofile(vim.env.MYVIMRC)
    end

    initlua.notify("InitLua: Reloaded successfully")

end, { desc = "Reload All Stuff" })
