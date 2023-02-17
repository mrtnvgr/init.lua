
_G.git = {}

function git.cmd(args, ...) return initlua.cmd("git -C " .. initlua.install_path .. " " .. args, ...) end

function git.pull(...) return git.cmd("pull --rebase", ...) end
