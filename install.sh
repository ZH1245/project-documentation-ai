#!/usr/bin/env bash
# Install the groundwork skill into ~/.claude/skills so it's available in every repo.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/groundwork"
DEST_DIR="${HOME}/.claude/skills/groundwork"

if [ ! -f "${SRC_DIR}/SKILL.md" ]; then
  echo "error: ${SRC_DIR}/SKILL.md not found — run this from the repo root." >&2
  exit 1
fi

mkdir -p "$(dirname "${DEST_DIR}")"
rm -rf "${DEST_DIR}"
cp -R "${SRC_DIR}" "${DEST_DIR}"

echo "Installed groundwork skill -> ${DEST_DIR}"
echo "Restart Claude Code, then run:  /groundwork onboard this repo"
