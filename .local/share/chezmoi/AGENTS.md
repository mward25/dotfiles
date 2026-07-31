# AGENTS.md

Dotfiles repository using GNU Stow for symlink management.

## Core Workflow

- **Setup**: `stow .` creates symlinks from `~/dotfiles/` to `~/`
- **Remove**: `stow -D .` removes all symlinks
- **Adding new files**: Move real file to `~/dotfiles/`, then run `stow .`

## Critical Rules

- **NEVER copy/move files to target locations** — use stow to create symlinks
- **ALWAYS edit files in `~/dotfiles/`** — avoid working in symlinked paths to prevent permission issues
- **When adding new dotfiles**: `mv ~/.config/foo/bar.conf ~/dotfiles/.config/foo/bar.conf && stow .`

## Directory Structure

- `.config/` — Multi-environment setup with window managers (qtile, awesome, hypr), terminals (wezterm, kitty, alacritty), nvim
- `bin/` — Custom scripts with external dependencies
- Root level — Shell configs (.bashrc, .vimrc, .tmux.conf), application configs

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
