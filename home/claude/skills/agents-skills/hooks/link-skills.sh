#!/bin/sh
# Link every skill under ~/.agents/skills into ~/.claude/skills, and every skill under
# <dir>/.agents/skills into <dir>/.claude/skills for <cwd> and each parent up to its repo
# root. Existing entries are never touched, except dangling links this script made.
# Links inside a repo are added to its info/exclude so they stay out of git status.
# Prints one line per link created or removed.
# Usage: link-skills.sh <cwd>
set -eu

cwd=${1:-$PWD}

# link_all <agents skills dir> <claude skills dir> [<git exclude file> <repo root>]
link_all() {
  src=$1 dst=$2 exclude=${3:-} root=${4:-}
  [ -d "$src" ] || return 0

  for skill in "$src"/*/; do
    skill=${skill%/}
    [ -f "$skill/SKILL.md" ] || continue
    target="$dst/$(basename "$skill")"
    [ -e "$target" ] || [ -L "$target" ] && continue
    mkdir -p "$dst"
    ln -s "$skill" "$target"
    echo "linked $target"
    if [ -n "$exclude" ]; then
      entry="/${target#"$root"/}"
      grep -qxF "$entry" "$exclude" 2>/dev/null || echo "$entry" >>"$exclude"
    fi
  done

  # Drop links into $src whose skill is gone.
  [ -d "$dst" ] || return 0
  for target in "$dst"/*; do
    [ -L "$target" ] && [ ! -e "$target" ] || continue
    case $(readlink "$target") in
      "$src"/*) rm "$target"; echo "unlinked $target" ;;
    esac
  done
}

link_all "$HOME/.agents/skills" "$HOME/.claude/skills"

if root=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null); then
  exclude=$(git -C "$cwd" rev-parse --path-format=absolute --git-path info/exclude)
  mkdir -p "$(dirname "$exclude")"
  dir=$cwd
  while :; do
    [ "$dir" = "$HOME" ] || link_all "$dir/.agents/skills" "$dir/.claude/skills" "$exclude" "$root"
    [ "$dir" = "$root" ] || [ "$dir" = / ] && break
    dir=$(dirname "$dir")
  done
elif [ "$cwd" != "$HOME" ]; then
  link_all "$cwd/.agents/skills" "$cwd/.claude/skills"
fi
