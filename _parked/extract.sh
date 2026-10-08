#!/bin/sh
# Extract the parked northernknife-ugc scaffold into a standalone directory,
# ready to `git init` and push. Does not touch this repo.
#
# Usage: ./_parked/extract.sh [destination]   (default: ../northernknife-ugc)

set -e

SRC="$(cd "$(dirname "$0")/northernknife-ugc" && pwd)"
DEST="${1:-$(cd "$(dirname "$0")/../.." && pwd)/northernknife-ugc}"

if [ -e "$DEST" ]; then
  echo "error: $DEST already exists — remove it or pick another destination" >&2
  exit 1
fi

mkdir -p "$DEST"
tar -C "$SRC" -cf - . | tar -C "$DEST" -xf -

# Restore the entry-point filename (parked so it isn't auto-loaded as nested
# project instructions while it sits inside my-client).
mv "$DEST/CLAUDE.md.parked" "$DEST/CLAUDE.md"

echo "Extracted to $DEST"
echo
echo "Next:"
echo "  cd $DEST"
echo "  git init -b main && git add -A && git commit -m 'Scaffold NorthernKnife UGC scripting repo'"
echo "  git remote add origin https://github.com/creativetstrategist-mark/northernknife-ugc"
echo "  git push -u origin main"
