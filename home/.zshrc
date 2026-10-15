# .zshrc

# Sigh, why Apple, why?
# tl;dr: `ls` isn't GNU, so can't use LS_COLORS, or any of the derivitive tech
# so, we stick with default colors for now
export CLICOLOR=1

# Sigh, part 2...
# pinentry seems to forget that it's being used to sign gpgp
# cref. https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# Homebrew Completions in zsh
# cref. zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# zsh
eval "$(fzf --zsh)"

# mise.jdx.dev as `asdf` alternative
eval "$(mise activate zsh)"

# Pretty, minimal and fast ZSH prompt
# cref. https://github.com/sindresorhus/pure#getting-started
autoload -U promptinit; promptinit
prompt pure

# Anonymous usage statistics are collected by default. To opt out, you can use
# either SHOPIFY_CLI_NO_ANALYTICS=1 or OPT_OUT_INSTRUMENTATION=true.
export SHOPIFY_CLI_NO_ANALYTICS=1

##
# User Alias
##

# Modern Tooling
alias vim='nvim'
alias cat='bat'

# Quick Views (color done w/ $CLICOLOR)
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# List top-level installed modules & direct dependencies
alias npm-ls="npm list --depth=1"

# Machine-specific settings and secrets; not tracked.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
