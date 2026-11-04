#!/usr/bin/env bash
# Copy core conventions plus one stack into a project and set up CLAUDE.md.
# Usage: ./scripts/init-project.sh <stack> <target-project-dir>
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

DEST="$TARGET/.claude/conventions"
mkdir -p "$DEST"
cp "$ROOT"/core/*.md "$DEST/"
cp "$ROOT/stacks/$STACK/stack.md" "$DEST/stack.md"
echo "Copied core + '$STACK' stack to $DEST"

if [[ -e "$TARGET/CLAUDE.md" ]]; then
  echo "CLAUDE.md already exists, leaving it untouched."
  echo "Make sure it imports these files:"
  for f in workflow coding testing documentation git-and-building review-checklist stack; do
    echo "  @.claude/conventions/$f.md"
  done
else
  cp "$ROOT/templates/CLAUDE.md" "$TARGET/CLAUDE.md"
  echo "Created $TARGET/CLAUDE.md. Fill in the project name, commands, and notes."
fi
