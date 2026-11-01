---
name: handoff
description: Summarize the current session into a permanent session file so any agent can continue the work. Use when Dor asks to summarize or close the session, create a handoff, or says "סכם את הסשן", "תסכם את השיחה", or "צור handoff".
argument-hint: "What will the next session be used for?"
---

Write a session summary so a fresh agent can continue the work, and so Dor can follow a project over months.

## Where to save

The main job of a handoff is to keep the sprint current (see `to-sprint`).

**If the session worked on a sprint:** save to that sprint's folder as `SESSION_NN.md`. Take the number at the moment you write the file: the highest existing number plus one. Use the deepest sprint the session worked in. Then:

1. In each EPIC file touched, tick every task finished this session with its evidence and date, and set the status of tasks and epics started, waiting, or blocked. Mirror epic statuses in the `SPRINT.md` table.
2. Update an epic's **Current State** when the session checked facts that changed it, with the date.
3. Insert new work discovered as tasks at their place in the order. Do not reorder without telling Dor.
4. If this was a sub-sprint, update its row in the parent `SPRINT.md`, up to the top sprint.
5. Add one row for this session to the **Progress Log** in `SPRINT.md`: date, epic, session link, summary.

In the summary, **Next** is the next step of this session's thread.

**If there is no sprint:** save to `sessions/<topic-slug>/<NN>-YYYY-MM-DD.md` at the project root, or under `~/Projects/ops/` if the session touched several projects. A topic that keeps growing should become a sprint.

Never overwrite an earlier summary.

## What to write

```markdown
# <Session title>

Date: YYYY-MM-DD · Sprint: <link to SPRINT.md> · Project(s): <names>

## The thread
<The work Dor asked this session for, in Dor's own framing: the epic or topic, and the goal.>

## What succeeded
- <Done and verified. Name the evidence: command output, a page checked, a commit.>

## What failed
- <What was tried and did not work, as observed. No invented causes.>

## Next
- <The exact next action first. Then what is still open or blocked, and on what.>

## Suggested skills
- <Which skills the next agent should call, and why.>
```

Write in Dor's language for the session. Keep each section short.

Do not duplicate content already captured in other artifacts (epics, research files, plans, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, card numbers, or personally identifiable information.

If Dor passed arguments, treat them as a description of what the next session will focus on and tailor the summary accordingly.

Finish by giving Dor the full absolute path of the file.
