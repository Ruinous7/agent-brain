#!/usr/bin/env bash
# Installs Agent Brain from this repo for Claude Code and Codex.
# Usage: bash setup.sh "<first name>"

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CODEX_DIR="${AGENT_BRAIN_CODEX_DIR:-$HOME/.codex}"
CLAUDE_DIR="${AGENT_BRAIN_CLAUDE_DIR:-$HOME/.claude}"
AGENTS_DIR="${AGENT_BRAIN_AGENTS_DIR:-$HOME/.agents}"
SKILLS=(brief codebase-design handoff to-sprint wait-what work-sprint writing-for-agents)

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

command -v perl >/dev/null || die "perl is required"

NAME="${1:-${AGENT_BRAIN_NAME:-}}"
if [[ -z "${NAME// /}" ]] && { : </dev/tty; } 2>/dev/null; then
  printf "What's your name? " >/dev/tty
  IFS= read -r NAME </dev/tty || true
fi
[[ -n "${NAME// /}" ]] || die 'no name given. Run: bash setup.sh "<first name>"'
[[ "$NAME" != *$'\n'* && "$NAME" != *$'\r'* ]] || die "the name must fit on one line"

TEMP_DIR="$(mktemp -d -t agent-brain-XXXXXX)"
trap 'rm -rf "$TEMP_DIR"' EXIT
cp "$REPO_DIR/AGENTS.md" "$TEMP_DIR/AGENTS.md"
cp -R "$REPO_DIR/skills" "$TEMP_DIR/skills"

export AGENT_BRAIN_NAME="$NAME"
find "$TEMP_DIR" -type f \( -name '*.md' -o -name '*.yaml' \) \
  -exec perl -pi -e 's/\bDor\b/$ENV{AGENT_BRAIN_NAME}/g' {} +

BACKUP_DIR="$AGENTS_DIR/backups/agent-brain-install-$(date +%Y%m%d-%H%M%S)"

backup() {
  local source="$1" relative="$2"
  if [[ -e "$source" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$relative")"
    cp -RL "$source" "$BACKUP_DIR/$relative"
  fi
}

install_brain() {
  local destination="$1"
  mkdir -p "$(dirname "$destination")"
  rm -f "$destination"
  cp "$TEMP_DIR/AGENTS.md" "$destination"
}

install_skills() {
  local destination="$1" skill
  mkdir -p "$destination"
  for skill in "${SKILLS[@]}"; do
    rm -rf "${destination:?}/$skill"
    cp -R "$TEMP_DIR/skills/$skill" "$destination/$skill"
  done
}

backup "$CLAUDE_DIR/CLAUDE.md" "claude/CLAUDE.md"
backup "$CODEX_DIR/AGENTS.md" "codex/AGENTS.md"
for skill in "${SKILLS[@]}"; do
  backup "$CLAUDE_DIR/skills/$skill" "claude/skills/$skill"
  backup "$AGENTS_DIR/skills/$skill" "agents/skills/$skill"
done

install_brain "$CLAUDE_DIR/CLAUDE.md"
install_brain "$CODEX_DIR/AGENTS.md"
install_skills "$CLAUDE_DIR/skills"
install_skills "$AGENTS_DIR/skills"

printf 'Installed Agent Brain for %s:\n' "$NAME"
printf '  %s\n' "$CLAUDE_DIR/CLAUDE.md" "$CODEX_DIR/AGENTS.md" \
  "$CLAUDE_DIR/skills/ (7 skills)" "$AGENTS_DIR/skills/ (7 skills)"
if [[ -d "$BACKUP_DIR" ]]; then
  printf 'Replaced files are backed up in %s\n' "$BACKUP_DIR"
fi
printf 'Restart open agent sessions to load the new brain.\n'
