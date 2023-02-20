local create_command = vim.api.nvim_create_user_command

create_command("InitLuaUpdate", function()

    -- TODO: async

    -- Update Self
    local pull_status, _ = initlua.git.pull(false)
    if pull_status then
        initlua.notify("InitLua: Repository pulled successfully")
        vim.cmd.InitLuaReload()
    else
        vim.api.nvim_err_writeln "InitLua: Unable to pull repository"
    end

    -- Update Packer
    initlua.packer.update()

    -- Update Tree-sitter
    vim.cmd.TSUpdate()

    -- Update LSP
    initlua.mason.update_all()

end, { desc = "Update All Stuff" })
