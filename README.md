# ✨Init.lua

![wakatime badge](https://wakatime.com/badge/user/5fea8bc3-faf2-4ced-9ae0-78ed7f87428f/project/893e579b-0331-4ddf-bbd4-24f1353d0832.svg)

**Init.lua** is a modern featureful Neovim distribution.

## Requirements

- Neovim >= **0.8.0** (**nightly**)
- Git
- Python 3 and `pynvim` pip package
- NodeJS and `neovim`, `tree-sitter-cli` npm packages
- _Any_ C compiler
- [Nerd Font](https://nerdfonts.com/) (Optional)

## Installation (Linux)

```console
pip install pynvim
npm install --global neovim tree-sitter-cli
git clone https://github.com/mrtnvgr/init.lua ~/.config/nvim
```

## Installation (Windows)

```console
powershell -ExecutionPolicy RemoteSigned -Command "irm get.scoop.sh | iex"
scoop install git
scoop bucket add versions
scoop install gcc neovim-nightly nodejs python
pip install pynvim
npm install --global neovim tree-sitter-cli
git clone https://github.com/mrtnvgr/init.lua %localappdata%/nvim/
```

## Commands

| Neovim command                  | Lua command                  | Description                           |
| ------------------------------- | ---------------------------- | ------------------------------------- |
| `InitluaUpdate`                 | `initlua.update()`           | update everything                     |
| `InitluaReload`                 | `initlua.reload()`           | reload `initlua.core.*` lua files     |
| `InitluaToggleFormatting`       | `initlua.format.toggle()`    | toggle null-ls formatting             |
| `InitluaGitPull`                | `initlua.git.pull()`         | pull updates from init.lua repository |
| `InitluaUpdateAllMasonPackages` | `initlua.mason.update_all()` | update all Mason packages             |

**All other commands are internal and are not recommended for use.**

## Acknowledgements

- [AstroNvim](https://github.com/AstroNvim/AstroNvim) (core.utils structure)
- [lazy.nvim](https://github.com/folke/lazy.nvim) (README structure)
- [nxvim](https://github.com/tenxsoydev/nxvim) (Better module structure)
