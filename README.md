# ✨Init.lua

![wakatime badge](https://wakatime.com/badge/user/5fea8bc3-faf2-4ced-9ae0-78ed7f87428f/project/893e579b-0331-4ddf-bbd4-24f1353d0832.svg)

**Init.lua** is a simple yet powerful modern Neovim distribution.

## Requirements

- Neovim >= **0.8.0**
- Git
- [Nerd Font](https://nerdfonts.com/) (Optional)

## Installation

```console
git clone https://github.com/mrtnvgr/init.lua ~/.config/nvim
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
