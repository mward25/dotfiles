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

<!-- OPENWIKI:START -->

## OpenWiki

This repository has a generated `openwiki/` evidence index. It is optional just-in-time context, not required startup reading.

- Do not enumerate, preload, or search wikis at task start. Use retrieval when the user asks for it, when unfamiliar architecture or dependency behavior materially affects the task, or when source inspection leaves an important uncertainty. Stop once the question is grounded.
- When those conditions apply and OpenWiki retrieval tools are available, use `openwiki_search` for just-in-time context and `openwiki_read` for the relevant complete sections. If search returns `workspace_required`, ask which listed workspace to use and retry with its ID.
- Use `openwiki_list_workspaces` or `openwiki_list_wikis` when workspace membership itself needs to be discovered.
- If the retrieval tools are unavailable, read `openwiki/quickstart.md` and follow its links to the relevant pages.
- Treat source code and tests as authoritative. A brief's unknowns and review items are verification gaps, not automatic requirements.
- Prefer the narrowest quiet validation that proves the changed behavior. Preserve complete failure output.

The scheduled OpenWiki GitHub Actions workflow refreshes the repository wiki. Do not hand-edit generated OpenWiki pages unless explicitly asked; prefer updating source code/docs and letting OpenWiki regenerate.

<!-- OPENWIKI:END -->
