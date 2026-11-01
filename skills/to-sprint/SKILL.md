---
name: to-sprint
description: Plan a sprint from a goal, a plan, or the current conversation, or add to an existing sprint. Writes SPRINT.md plus one EPIC file per epic, in the order the work must happen, ready for work-sprint and /loop. Use when Dor asks to plan a sprint, organize or document the work, or turn a goal into ordered epics. Works for code and non-code work.
---

# To Sprint

A **sprint** is one topic of work toward one outcome. **What Dor Wants** is its center: every epic, task and done-check exists to deliver it. A sprint lives as local files, so any agent can pick it up, `work-sprint` can run it in a loop, and `handoff` keeps it current.

## Files

```text
sprints/<YYYY-MM>-<slug>/
  SPRINT.md              index: what Dor wants, epics in order, risks, done, log
  EPIC-NN_<slug>.md      one per epic, numbered in the order the work must happen
  SESSION_NN.md          written by handoff
  RESEARCH_*.md, DESIGN_*.md   optional, linked from the epic that needs them
```

Place it at `sprints/<YYYY-MM>-<slug>/` in the project root. If it spans several projects, use `~/Projects/ops/sprints/<YYYY-MM>-<slug>/`. An epic sized XL (more than 3 sessions) becomes a **sub-sprint**: its own folder with the same files, linked from its row.

## The work is linear

Epics are numbered in Dor's order, and tasks inside an epic are ordered too. An epic waits only on what its **Waits on** column names. The **current epic** is the one Dor names; when Dor names none, it is the first epic that is not `done`, not `waiting`, and whose Waits on is done. The **next task** is its first unchecked task.

Status is one of: `todo`, `doing`, `waiting: <date or person>`, `needs-dor: <the decision>`, `blocked: <what failed>`, `done`. A waiting epic or task stays in its place in the order.

## Process

1. **Gather context.** Work from the conversation. Read any reference Dor passes, the latest `SESSION_NN.md` of the thread you are planning (its header names the thread), and the real state of everything the sprint touches: code, config, live systems. Write down only what you checked, with the date. Do not plan from memory.
2. **Write What Dor Wants first,** for the sprint and for each epic, in Dor's own words. Quote Dor. Then say in one line what it means.
3. **Order the epics.** Work already done becomes the first epics or tasks, marked `done` with evidence, so the sprint documents everything. Then the rest in the order it must happen. Each task is one outcome Dor can check, such as "Firecrawl key rotated". For code, each task is a thin slice that works end to end.
4. **Write each Definition of Done** so every item checks something in What Dor Wants. An item that traces to nothing Dor asked for is cut. Something Dor asked for with no item means the plan is missing work.
5. **Show Dor** What Dor Wants and the epics in order. Fix them until Dor approves.
6. **Write the files.** When adding to an existing sprint, edit it in place.

Redact secrets. Finish by giving Dor the full absolute path of `SPRINT.md` and the loop command:

```text
/loop /work-sprint <absolute path to SPRINT.md> [EPIC-NN]
```

Name an epic, and the loop works only that epic.

## SPRINT.md

```markdown
# Sprint: <name>

> **Status:** <status> · **Started:** YYYY-MM-DD · **Parent:** <link, sub-sprints only>
> **Goal:** <one sentence>

## What Dor Wants
<Dor's words, quoted. Then one line on what it means.>

## Epics, in order
| # | Epic | Status | Scope | Waits on |
|---|------|--------|-------|----------|
| 01 | [<name>](EPIC-01_<slug>.md) | done | S (1 session) | — |
| 02 | [<name>](EPIC-02_<slug>.md) | doing | M (2 sessions) | — |

## Blockers & Risks
| Risk | Status | Impact | Mitigation |
|------|--------|--------|------------|

## Definition of Done
- [ ] <checks something in What Dor Wants>

## Progress Log
| Date | Epic | Session | Summary |
|------|------|---------|---------|
```

## EPIC-NN_<slug>.md

```markdown
# EPIC-NN: <name>

> **Status:** <status> · **Scope:** S/M/L/XL (<sessions>) · **Sprint:** [<name>](SPRINT.md)

## What Dor Wants
<Dor's words for this epic, quoted. Then one line on what it means.>

## Current State — verified YYYY-MM-DD
<Only what was checked, with evidence: file:line, command output, a page read.>

## Desired Behavior
<What is true after this epic.>

## Tasks
- [ ] 1. <one checkable outcome>
- [ ] 2. <outcome> (`needs-dor: <the decision>`)
- [x] 3. <outcome>. <evidence, YYYY-MM-DD>

## Definition of Done
- [ ] <check, including tests: command, page, simulator walk; traces to What Dor Wants>

## Risks
| Risk | Mitigation |
|------|------------|
```
