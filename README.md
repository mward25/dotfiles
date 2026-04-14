# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

Clone the repo into your home directory:

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

Then run stow to symlink everything into place:

```sh
stow .
```

Stow uses the parent of the current directory (`~`) as the target. It mirrors the directory structure here and creates symlinks for each file — so `~/dotfiles/.config/kitty/kitty.conf` becomes `~/.config/kitty/kitty.conf`, and so on.

To remove all symlinks:

```sh
stow -D .
```

## How it works

- **Source of truth** is always the file inside `~/dotfiles/`.
- The symlinks in `~` (e.g. `~/.config/`, `~/bin/`) point back here.
- Edit files from either path — they resolve to the same inode.
- When reading or modifying tracked config files, prefer working from `~/dotfiles/` to avoid permission prompts from tools that don't follow symlinks.

## Adding new dotfiles

Move the real file into the appropriate place under `~/dotfiles/`, then re-run `stow .`:

```sh
mv ~/.config/foo/bar.conf ~/dotfiles/.config/foo/bar.conf
stow .
```

Stow will create the symlink at the original location automatically.
