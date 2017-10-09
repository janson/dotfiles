source ~/.profile
### ### ### ### #
# 256 color if available
### ### ### ### #
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

# Because we like to look in the past.
export HISTSIZE=10000

# Because we like to know when stuff in the past happens.
HISTTIMEFORMAT='%F %T ' 
export HISTTIMEFORMAT

# Add local path info, with usr/local taking precedence before OSX versions
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:$MANPATH

# Sometimes, in a busy office, we hit GitHub's API rate limit when brewing
export HOMEBREW_GITHUB_API_TOKEN=9aa6ddc05b2f40f70e6c9f0ef0b934a65d784b44

# Add npm managed binaries to the path
export PATH=/usr/local/share/npm/bin:$PATH

# Add rbenv to bash so that it loads every time you open a terminal
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

###	###	###	###	#
# Customized prompts:
# user@domain current directory (git_repo_branch)
# (See color-list.sh for colors.)

# Determine what character to use in place of the '$' for my prompt.
function repo_char {
  git branch >/dev/null 2>/dev/null && echo '☿' && return
  echo '$'
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
YELLOW="\[\033[0;33m\]"
LIGHT_YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
MAGENTA="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
NO_COLOUR="\[\033[0m\]"

PS1="$LIGHT_RED\u@\h $CYAN\w $MAGENTA\$(parse_git_branch)$NO_COLOUR\n\$(repo_char) "
###	###	###	###	#

# GRC
# source "`brew --prefix`/etc/grc.bashrc"

###	###	###	###	#
# Bash Tab completion
###	###	###	###	#

# Homebrew installed library
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Adds sudo to list of completion
complete -cf sudo

###	###	###	###	#
# Aliases
###	###	###	###	#

# Add trailing space to sudo to allow for sudo executio of other aliases
alias sudo='sudo '

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Syntax highlighting (optional to reduce performance hit)
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'
#alias lessh='LESSOPEN="| ${LESSPIPE} %s" less -M '

# Misc 
# alias less='less -r'                        # raw control characters
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hFG'	# classify files in colour
alias ll='ls -l' 	# long list
alias la='ls -A'	# all but . and ..
alias lla='ls -lA'	# everything
alias l='ls -CF'    #
#
###
