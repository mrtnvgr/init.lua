initlua.packer = {}

function initlua.packer.update()
    local status, packer = pcall(require, "packer")
    if not status then
        vim.api.nvim_err_writeln "Unable to access packer"
        return
    end

    vim.api.nvim_create_autocmd("User", {
        once = true,
        desc = "Close Packer window after update",
        pattern = "PackerComplete",
        callback = function()
            local status, packer_display = pcall(require, "packer.display")
            if not status then
                vim.api.nvim_err_writeln "Unable to access packer display"
            else
                packer_display.quit()
            end
        end,
    })

    packer.sync()
end
