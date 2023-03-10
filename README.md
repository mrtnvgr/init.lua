# ✨Init.lua

![wakatime badge](https://wakatime.com/badge/user/5fea8bc3-faf2-4ced-9ae0-78ed7f87428f/project/893e579b-0331-4ddf-bbd4-24f1353d0832.svg)

_**WARNING: Heavily under development! There are some bugs and stuff that needs to be done.**_

**Init.lua** is a modern featureful Neovim distribution.

## Requirements

- Neovim >= **0.8.0** (**nightly**)
- Git
- Python 3 and `pynvim` pip package
- NodeJS and `neovim`, `tree-sitter-cli` npm packages
- _Any_ C compiler
- [Nerd Font](https://nerdfonts.com/)

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
scoop bucker add nerd-fonts
scoop install CascadiaCode-NF-Mono # change your cmd font to this
python -m pip install pynvim
npm install --global neovim tree-sitter-cli
git clone https://github.com/mrtnvgr/init.lua %localappdata%/nvim/
```

## Commands

| Neovim command             | Lua command                    | Keymap        | Description               |
| -------------------------- | ------------------------------ | ------------- | ------------------------- |
| `InitluaUpdate`            | `initlua.updater.update()`     | `<leader>au`  | update everything         |
| `InitluaToggleFormatting`  | `initlua.format.toggle()`      | `<leader>atf` | toggle null-ls formatting |
| `InitluaSelectColorscheme` | `initlua.select_colorscheme()` | `<leader>asc` | pick a colorscheme        |

**All other commands are internal and are not recommended for use.**

## Acknowledgements

- [AstroNvim](https://github.com/AstroNvim/AstroNvim) (core.utils structure)
- [lazy.nvim](https://github.com/folke/lazy.nvim) (README structure)
- [nxvim](https://github.com/tenxsoydev/nxvim) (Better module structure)
