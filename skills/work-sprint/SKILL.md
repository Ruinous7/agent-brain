---
name: work-sprint
description: Work a sprint written by to-sprint, one task per run, so /loop can repeat it until the sprint is done or needs Dor. Use when Dor says work the sprint, continue the sprint, next task, or runs /loop on a SPRINT.md.
argument-hint: "<absolute path to SPRINT.md> [EPIC-NN]"
---

# Work Sprint

One run does **one task** of a sprint written by `to-sprint`, writes the result back into the files, and decides whether the loop goes on. The files are the only memory between runs, so read them fresh every run and leave them true.

Run it once, or in a loop:

```text
/loop /work-sprint <absolute path to SPRINT.md> [EPIC-NN]
```

Name an epic, and the loop works only that epic.

## One run

1. **Find the task.** Read `SPRINT.md` and its What Dor Wants. The epic is the one Dor named in the arguments; with none named, it is the first row that is not `done`, not `waiting`, and whose Waits on is done. Open its EPIC file and read its What Dor Wants and Current State. The task is the first unchecked one.
   - The named epic is `done`: **stop**.
   - No epic named, and every epic `done`: go to step 5.
   - No epic named, and every remaining epic waiting: **stop**.
2. **Gate it.** **Stop** and ask Dor when the task is `needs-dor`, or when doing it would push, deploy, delete, pay, send a message, or change an account. Ask in one line, with the decision and your recommendation.
   - Dor approved the epic, and the task names that exact action (a Share, a named delete, a deploy): do it without asking. Anything the epic does not name still stops.
3. **Do the task.** Check the facts it depends on first; when they differ from Current State, update Current State with the date before acting. Then do it and verify the outcome: run the command, read the page, open the result.
4. **Write it back.**
   - Tick the task with its evidence and date. Set the epic's status in its header and in the `SPRINT.md` table.
   - When the last task is ticked, walk the epic's Definition of Done. Tick each item with evidence. All ticked: the epic is `done`. One fails: add the task that fixes it, in its place in the order, marked `needs-dor: approve this task`.
   - New work found: add it as a task at its place in the order, marked `needs-dor: approve this task`. Dor approved the epic as it was written; a task you add runs only after Dor approves it.
   - A task that failed twice: mark it `blocked: <what failed, as observed>` and **stop**.
   - Add one row to the Progress Log: date, epic, summary.
5. **Close the sprint** when every epic is `done`: walk the sprint's Definition of Done the same way, set the sprint `done`, and **stop**.

A run that does not stop continues the loop to the next task. A stop ends the loop: under `/loop`, end it, then tell Dor in two lines what was done and what is needed from Dor.
