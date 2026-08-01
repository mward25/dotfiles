# AGENTS.md

Dotfiles repository managed with [chezmoi](https://www.chezmoi.io/).

## Core Workflow

- **Setup**: `chezmoi init --apply <repo-url>` clones/initializes and applies the dotfiles to `~`
- **Apply**: `chezmoi apply` updates `~` from the source state
- **Update**: `chezmoi update` pulls changes and re-applies
- **Adding new files**: `chezmoi add ~/.config/foo/bar.conf` then edit from the source directory

## Critical Rules

- **ALWAYS edit files in the chezmoi source directory** — do not work in live paths under `~` and assume changes will be picked up automatically
- **Use `chezmoi add` or `chezmoi edit`** to manage target files; never manually copy files from `~` into the source tree
- **When adding new dotfiles**: `chezmoi add ~/.config/foo/bar.conf` then commit the resulting source file

## Directory Structure

- `dot_config/` — Multi-environment setup with window managers (qtile, awesome, hypr), terminals (wezterm, kitty, alacritty), nvim
- `dot_bashrc`, `dot_vimrc`, etc. — Shell and application configs at the root of the source tree
- `bin/` — Custom scripts with external dependencies
- `.chezmoiignore.tmpl` — OS-conditional exclusions (Linux-only configs are skipped on Windows)
- `run_after_*.sh.tmpl` — Post-apply scripts that copy configs to Windows-specific paths where needed

## Cross-Platform Notes

The repo supports Linux and Windows via chezmoi templates and `.chezmoiignore.tmpl`:

- Linux-only configs (window managers, Wayland/X11 tooling, GTK/Qt themes, Arch-specific tools) are ignored on Windows.
- Bash, tmux, vim, Neovim, yazi, bat, and WezTerm are kept on Windows, typically under Git Bash.
- Neovim and yazi configs are copied to their Windows-specific paths (`%LOCALAPPDATA%\nvim`, `%APPDATA%\yazi\config`) by `run_after_*` scripts because chezmoi cannot natively map one source directory to two target paths.

## Dependencies for bin/ scripts

Scripts may require these external tools (check before suggesting modifications):

- `autorandr` + `nitrogen` (deskConfig)
- `scrot` + `magick` + `i3lock` (lock screen)
- `dunst` + `espeak` (dunst_espeak.sh)

## Neovim Setup

- Uses lazy.nvim plugin manager (lazy-lock.json tracks versions)
- LSP servers: clangd, qmlls (qmlls6), harper_ls, lua_ls
- Custom K mapping for word lookup (man/tldr/web browser)
- Catppuccin macchiato colorscheme required
- Custom window resize mode with `<leader>wr`

## Git Ignore Patterns

Currently ignores:

- `.vim/undo` (vim undo files)
- `.config/koreader/cache` and screenshots (e-reader app data)
- `.config/koreader/settings/*.sqlite3` (databases)
