# dotfiles

Minimal bootstrap for a new Mac. Files in `home/` are symlinked into `~`.

## New laptop

1. Install the Command Line Tools (gives you git):

       xcode-select --install

2. Install [Homebrew](https://brew.sh) with the official installer.

3. Clone over https (no SSH key yet) and install the core packages:

       git clone https://github.com/janson/dotfiles.git ~/code/dotfiles
       cd ~/code/dotfiles
       brew bundle

   For a fuller setup, also run `brew bundle --file=Brewfile.extra`.

4. Link the dotfiles. Anything already in the way is moved to
   `~/.dotfiles-backup/<timestamp>/`.

       ./install.sh --dry-run
       ./install.sh

5. Install [vim-plug](https://github.com/junegunn/vim-plug), then run
   `:PlugInstall` in nvim.

6. Install the MonoLisa font (licensed, so not in this repo).

7. Create keys, then switch the remote to SSH:

       ssh-keygen -t ed25519
       gpg --full-generate-key
       gh auth login
       git remote set-url origin git@github.com:janson/dotfiles.git

## Per-machine settings

These files are sourced if present and never committed. Put secrets, work
settings and one-off tools here:

- `~/.zshrc.local`
- `~/.gitconfig.local`, e.g. `[user] signingkey = ...`

## Adding a file

`.gitignore` ignores everything by default. To track a new file, put it
under `home/` at its path relative to `~`, add a `!/home/...` line to
`.gitignore`, and re-run `./install.sh`.
