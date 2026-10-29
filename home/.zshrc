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
# $HOMEBREW_PREFIX comes from `brew shellenv` in .zprofile.
typeset -U fpath
if [[ -n $HOMEBREW_PREFIX ]]; then
  FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$FPATH
fi

# Rebuild the completion dump at most once a day; otherwise trust the cache.
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) || ! -e ~/.zcompdump ]]; then
  compinit
else
  compinit -C
fi

# History: large, shared across sessions, no duplicates.
# A leading space keeps a command out of history.
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS EXTENDED_HISTORY

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
alias b='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Quick Views (color done w/ $CLICOLOR)
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# List top-level installed modules & direct dependencies
alias npm-ls="npm list --depth=1"

# Machine-specific settings and secrets; not tracked.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
