
_G.initlua = {}
local stdpath = vim.fn.stdpath

initlua.install_path = stdpath "config"

function initlua.cmd(cmd, show_error)
    if vim.fn.has "win32" == 1 then cmd = { "cmd.exe", "/C", cmd } end
    local result = vim.fn.system(cmd)
    local success = vim.api.nvim_get_vvar "shell_error" == 0
    if not success and (show_error == nil and true or show_error) then
        vim.api.nvim_err_writeln("Error running command: " .. cmd .. "\nError message:\n" .. result)
    end
    return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

function initlua.notify(msg, type)
    vim.schedule(function() vim.notify(msg, type, {}) end)
end
