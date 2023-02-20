
initlua.git = {}

function initlua.git.cmd(args, ...) return initlua.cmd("git -C " .. initlua.install_path .. " " .. args, ...) end

function initlua.git.pull(...) return initlua.git.cmd("pull --rebase", ...) end
