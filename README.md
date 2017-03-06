# dotfiles
There are many dotfiles; these are mine.

## Setup

1. install xcode command line tools
    
    xcode-select --install
    
1. clone this repo

    git clone https://github.com/janson/dotfiles.git

1. install homebrew
    
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

1. install the [mas-cli](https://github.com/mas-cli/mas)

    brew install mas

1. sign into app store via mas, if needed

    mas signin email@email.com

1. install brews, casks, and AppStore bundles

    brew bundle install

## Inspired by, and thanks to:

* dotfiles - [mathiasbynens](https://github.com/mathiasbynens/dotfiles), [driesvints](https://github.com/driesvints/dotfiles)
* .macos - @mathiasbynens [.macos](http://mths.be/macos) and Kevin Suttle [OSXDefaults](https://github.com/kevinSuttle/macOS-Defaults) 
* Brewfile - Tania Rascia [Setting up a Brand New Mac for Development](https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/)
* Security - [macOS Security & Privacy Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide)
