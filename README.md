# dotfiles

This repo is structured around maintaining consistency and providing easy setup for common terminal-related configuration files.

A dotfiles directory within the main home directory is populated using the `bootstrap.sh` script, and symlinks are created within the appropriate subdirectories using GNU Stow.

## Home Directory Management

Use `stow [utility name]` to link configuration of any of the following to this directory:
- aliases
- kitty
- nvim
- starship
- tmux
- yazi
- zsh

Alternatively, use the following line in this directory to link all of the above:

```
stow */
```

## Additional Configuration

### tmux

After running `stow tmux`, ensure tpm is installed for tmux plugins.

```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
