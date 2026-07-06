#!/usr/bin/env bash
# Install the skill into ~/.claude/skills so it's available in every repo.
#
# Usage:
#   ./install.sh                 # installs as `groundwork` -> /groundwork
#   ./install.sh <name>          # installs under your own name -> /<name>
#   ./install.sh docsetup        # e.g. -> /docsetup
set -euo pipefail

NAME="${1:-groundwork}"

# skill names: lowercase letters, digits, hyphens
if ! printf '%s' "$NAME" | grep -Eq '^[a-z0-9-]+$'; then
  echo "error: skill name must be lowercase letters, digits, and hyphens only (got: '$NAME')" >&2
  exit 1
fi

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/groundwork"
DEST_DIR="${HOME}/.claude/skills/${NAME}"

if [ ! -f "${SRC_DIR}/SKILL.md" ]; then
  echo "error: ${SRC_DIR}/SKILL.md not found — run this from the repo root." >&2
  exit 1
fi

mkdir -p "$(dirname "${DEST_DIR}")"
rm -rf "${DEST_DIR}"
cp -R "${SRC_DIR}" "${DEST_DIR}"

# rewrite the frontmatter `name:` so the skill is invoked as /<name>
if [ "$NAME" != "groundwork" ]; then
  sed -i.bak -E "s/^name: groundwork$/name: ${NAME}/" "${DEST_DIR}/SKILL.md"
  rm -f "${DEST_DIR}/SKILL.md.bak"
fi

echo "Installed skill '${NAME}' -> ${DEST_DIR}"
echo "Restart Claude Code, then run:  /${NAME} onboard this repo"
