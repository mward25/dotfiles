# dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Setup

Install chezmoi, then initialize from this repo:

```sh
chezmoi init --apply <repo-url>
```

This checks out the repository and applies the dotfiles to your home directory.

## How it works

- The **source directory** is the chezmoi working tree (the directory that holds this `README.md`).
- The **target directory** is `~`. chezmoi applies files from the source tree to the corresponding paths under your home directory.
- Files such as `dot_config/kitty/kitty.conf` in the source become `~/.config/kitty/kitty.conf` on the target system.
- **Source of truth** is always the file inside the chezmoi source directory.
- Edit files from the source directory when possible; for existing configs you can also use `chezmoi edit <target-file>` or `chezmoi cd` to enter the source directory.

## Adding new dotfiles

Tell chezmoi to manage a config file in place:

```sh
chezmoi add ~/.config/foo/bar.conf
```

Then edit it from the source directory or with `chezmoi edit ~/.config/foo/bar.conf`.

## Applying and updating

Apply the latest source state to `~`:

```sh
chezmoi apply
```

Pull upstream changes and re-apply:

```sh
chezmoi update
```
