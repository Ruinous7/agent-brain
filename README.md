# Agent Brain

The exact brain Dor Mizrahi uses with Claude Code and Codex: one `AGENTS.md` and
7 skills.

## Install

Give this repo's URL to Claude Code or Codex and ask it to install the brain:

```text
https://github.com/Ruinous7/agent-brain
```

## For AI agents

If your user asked you to install this repo:

1. Tell your user that `setup.sh` replaces `~/.claude/CLAUDE.md` and
   `~/.codex/AGENTS.md`, and backs up the old files first.
2. Ask for their first name. It goes in the brain in place of "Dor".
3. Read `setup.sh` in this repo, then run:

```bash
git clone https://github.com/Ruinous7/agent-brain.git ~/agent-brain
bash ~/agent-brain/setup.sh "<first name>"
```

4. Tell your user to restart their agent.

## What it does

- Copies `AGENTS.md` to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`
- Copies 7 skills to `~/.claude/skills/` and `~/.agents/skills/`
- Backs up the files it replaces to `~/.agents/backups/agent-brain-install-<date>/`

Your other skills, settings, permissions, MCP servers, and project files stay as
they are. It needs bash, so on Windows use WSL or Git Bash.

## Skills

- `to-sprint`: plans a sprint as `SPRINT.md` plus one `EPIC` file per epic
- `work-sprint`: works one task of a sprint and writes it back
- `handoff`: writes a session file and keeps the sprint current
- `brief`: explains the current work: what happened and what came back
- `wait-what`: finds what you are on and explains it simply when you are lost
- `writing-for-agents`: how to write skills and `AGENTS.md`
- `codebase-design`: deep modules, seams, and interfaces

## License

MIT. See `LICENSE`. Adapted workflows keep their attribution in
`THIRD_PARTY_NOTICES.md`.
