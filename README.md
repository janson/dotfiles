# dotfiles

There are many dotfiles; these are mine. Everything in `home/` gets symlinked into `~`.

## Fresh setup

1. Get/confirm git via the Command Line Tools, then [Homebrew](https://brew.sh):

       xcode-select --install

2. Clone over https, wherever repos live on this machine, and brew the basics:

       git clone https://github.com/janson/dotfiles.git
       cd dotfiles
       brew bundle

   Optional `brew bundle --file=Brewfile.extra`.

3. Link everything. Links point at this clone, so if you move it, re-run.

       ./install.sh --dry-run
       ./install.sh

4. The bits that can't live here:
   - [vim-plug](https://github.com/junegunn/vim-plug), then `:PlugInstall`
   - MonoLisa, or my current monospaced obession... 
   - gpg && ssh keys

## Just this machine

Secrets, additional settings, and one-offs go in `~/.zshrc.local` and
`~/.gitconfig.local` (e.g. `[user] signingkey = ...`).

## Adding a file

`.gitignore` ignores everything, on purpose. Add the file under `home/`, add a `!/home/...` line to `.gitignore`, and
re-run `./install.sh`.

## Inspired by, and thanks to:

* dotfiles - [mathiasbynens](https://github.com/mathiasbynens/dotfiles), [driesvints](https://github.com/driesvints/dotfiles)
* .macos - @mathiasbynens [.macos](http://mths.be/macos) and Kevin Suttle [OSXDefaults](https://github.com/kevinSuttle/macOS-Defaults)
* Brewfile - Tania Rascia [Setting up a Brand New Mac for Development](https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/)
* Security - [macOS Security & Privacy Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide)
