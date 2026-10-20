
# Opt out of Homebrew analytics; refuse https -> http redirects on download.
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
