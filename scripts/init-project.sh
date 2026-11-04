#!/usr/bin/env bash
# Set up a project with the core conventions, one stack, and shared tooling files.
# Usage: ./scripts/init-project.sh <stack> <target-project-dir>
#
# Conventions in .claude/conventions/ are always refreshed.
# Everything else (CLAUDE.md, README.md, CI, .gitignore, hooks, ...) is copied
# only if it does not already exist, so your project's own files are never overwritten.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  echo "Usage: $0 <stack> <target-project-dir>"
  echo "Available stacks: $(ls "$ROOT/stacks" | grep -v '^_' | tr '\n' ' ')"
  exit 1
}

STACK="${1:-}"
TARGET="${2:-}"
[[ -z "$STACK" || -z "$TARGET" ]] && usage

if [[ "$STACK" == _* || ! -d "$ROOT/stacks/$STACK" ]]; then
  echo "Unknown stack: $STACK"
  usage
fi
if [[ ! -d "$TARGET" ]]; then
  echo "Target directory not found: $TARGET"
  exit 1
fi

# Copy one file unless the destination exists.
copy_new() {
  local src="$1" dest="$2"
  if [[ -e "$dest" ]]; then
    echo "  skipped (exists): ${dest#"$TARGET"/}"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  created:          ${dest#"$TARGET"/}"
  fi
}

# Copy every file in a directory tree (dotfiles included), never overwriting.
copy_tree() {
  local src="$1"
  [[ -d "$src" ]] || return 0
  while IFS= read -r -d '' file; do
    copy_new "$file" "$TARGET/${file#"$src"/}"
  done < <(find "$src" -type f -print0)
}

echo "Conventions:"
DEST="$TARGET/.claude/conventions"
mkdir -p "$DEST"
cp "$ROOT"/core/*.md "$DEST/"
cp "$ROOT/stacks/$STACK/stack.md" "$DEST/stack.md"
echo "  refreshed core + '$STACK' stack in .claude/conventions/"

echo "Shared files:"
copy_tree "$ROOT/templates/common"

echo "Stack tooling ($STACK):"
copy_tree "$ROOT/stacks/$STACK/tooling"

echo "Project docs:"
copy_new "$ROOT/templates/README.project.md" "$TARGET/README.md"

if [[ -e "$TARGET/CLAUDE.md" ]]; then
  echo "  skipped (exists): CLAUDE.md"
  echo "Make sure CLAUDE.md imports these files:"
  for f in claude-behavior workflow coding security testing documentation git-and-building review-checklist stack; do
    echo "  @.claude/conventions/$f.md"
  done
else
  cp "$ROOT/templates/CLAUDE.md" "$TARGET/CLAUDE.md"
  echo "  created:          CLAUDE.md"
fi

echo
echo "Next: fill in CLAUDE.md and README.md, check the commands in .github/workflows/ci.yml"
echo "match your package scripts, then commit."
