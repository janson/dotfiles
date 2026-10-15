#!/bin/sh
# Symlink every file under home/ into $HOME.
#
# Safe to re-run: correct links are left alone, and anything else in the
# way is moved to ~/.dotfiles-backup/<timestamp>/ first.
#
#   ./install.sh            link files
#   ./install.sh --dry-run  print what would happen

set -eu

repo=$(cd "$(dirname "$0")" && pwd)
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)-$$"
dry_run=false
[ "${1:-}" = "--dry-run" ] && dry_run=true

run() {
  if $dry_run; then echo "  would: $*"; else "$@"; fi
}

git -C "$repo" ls-files home | sed 's#^home/##' | while read -r rel; do
  src="$repo/home/$rel"
  dst="$HOME/$rel"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      ~/$rel"
    continue
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "backup  ~/$rel"
    run mkdir -p "$backup/$(dirname "$rel")"
    run mv "$dst" "$backup/$rel"
  fi

  echo "link    ~/$rel"
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
done

if [ -d "$backup" ]; then
  echo "Replaced files are in $backup"
fi
