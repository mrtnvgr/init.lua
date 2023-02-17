initlua.mason = {}

function initlua.mason.update_all()
    local registry_avail, registry = pcall(require, "mason-registry")
    if not registry_avail then
        vim.api.nvim_err_writeln "Unable to access mason registry"
        return
    end

    local installed_pkgs = registry.get_installed_packages()
    local running = #installed_pkgs
    local no_pkgs = running == 0

    if no_pkgs then
        return
    end

    for _, pkg in ipairs(installed_pkgs) do
        pkg:check_new_version(function(update_available, _)
            if update_available then
                initlua.notify(("Mason: Updating %s"):format(pkg.name))
                pkg:install():on("closed", function() initlua.notify("Mason: Updated %s"):format(pkg.name) end)
            else
                initlua.notify(("Mason: No updates for %s"):format(pkg.name))
            end
        end)
    end

end
