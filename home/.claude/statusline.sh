#!/bin/sh
# Claude Code status line: cwd, git branch (* if tracked files changed), model, effort, context used.
# Reads the session JSON on stdin.

input=$(cat)
field() { printf '%s' "$input" | jq -r "$1 // empty"; }

cwd=$(field '.workspace.current_dir // .cwd')
model=$(field '.model.display_name')
effort=$(field '.effort.level')
used=$(field '.context_window.used_percentage')

case $cwd in "$HOME"*) short="~${cwd#"$HOME"}" ;; *) short=$cwd ;; esac
out=$(printf '\033[38;5;67m%s\033[0m' "$short")

if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  # -uno skips the untracked-file walk, which is the slow part in big repos.
  dirty=''
  [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain -uno 2>/dev/null)" ] && dirty='*'
  [ -n "$branch" ] && out="$out $(printf '\033[38;5;242m%s%s\033[0m' "$branch" "$dirty")"
fi

[ -n "$model" ] && out="$out $(printf '\033[90m%s\033[0m' "$model")"
[ -n "$effort" ] && out="$out $(printf '\033[90m· %s\033[0m' "$effort")"
[ -n "$used" ] && out="$out $(printf '\033[90mctx %.0f%%\033[0m' "$used")"
printf '%s' "$out"
