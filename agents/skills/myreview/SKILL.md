---
name: myreview
description: Review a local branch or a GitHub PR and write verified findings to the Obsidian vault using the verified-doc rules. Use when the user runs /myreview, or asks to review "this branch", "my changes", or a PR such as "#100".
user-invocable: true
allowed-tools: Write(//Users/michaelmead/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/Claude Docs/**)
---

# My review

The output is a list of facts the user can go and check.
Every finding has an exact location, a verified cause, and a realistic trigger.
Prose hides details. Keep it short.

## 1. Pick the target

Decide from the argument and the conversation. Ask only if both readings are plausible.

**Local** (`this branch`, `my changes`, no argument):

```
git symbolic-ref --short refs/remotes/origin/HEAD   # default branch
git merge-base HEAD origin/<default>
git diff <merge-base>                               # includes uncommitted work
git status --short                                  # untracked files are part of the change
```

Read changed files from the working tree.

**Remote** (`#100`, a PR URL):

```
gh pr view 100 --json number,title,body,baseRefName,headRefOid,author,files
git fetch origin pull/100/head:refs/myreview/pr-100 <base>
git merge-base refs/myreview/pr-100 origin/<base>
git diff <merge-base> refs/myreview/pr-100
```

Read files with `git show refs/myreview/pr-100:<path>`.
Never check out the PR. Never touch the working tree.

## 2. Git exception

The global rule "don't use git commands" does not apply to this skill for read-only commands:
`diff`, `log`, `show`, `merge-base`, `blame`, `status`, `symbolic-ref`, `grep`,
and `fetch` into `refs/myreview/*`.
Never run a command that changes branches, the index, the working tree, or a remote.

## 3. Read before judging

- Read the PR body or branch commits for intent.
- Read every changed file in full, not only the hunks.
- For each changed function: find its callers and read the ones the change affects.
- Read the types and schemas the changed code depends on.
- Check how the code actually runs: a cron job, a request handler, a one-off script, a migration.
  That decides which failure modes are real.

## 4. What to look for

**Correctness.** Wrong logic, wrong data flow, broken callers, unhandled states that the
types or the data allow, errors swallowed by try/catch, queries whose results are not used.

**Code that should be rewritten.**
- New code that copies existing code. For each new function or block over about 10 lines,
  grep the repo for the same calls, literals, and similar names. Report both locations and the refactor.
- New helpers that duplicate a library or a utility already in the repo.
- Code that is much longer than it needs to be.

**Tests.**
- Tests that assert on mocks instead of on behavior.
- Tests that mock the unit under test, or so much around it that the assertion would pass
  with a wrong value. Name the line that makes it pass regardless.
- Tests that only check that something was called, or that it did not throw.
- Changed logic with no test that would fail if the logic broke.

**Comments.** Flag every comment the change adds. State the rename or extraction that
removes the need for it. Flag existing comments that the change made wrong.

**Design.** Wrong layer, tight coupling, a function doing two jobs, data passed "just in case",
types that allow illegal states, dead code the change introduces, names that mislead.
A principle is not a finding by itself. Name what it breaks or makes harder, and where.

## 5. The gate

A finding goes in the doc only if all of these are true:

1. **Location verified.** File and line read in this session, at the reviewed revision.
2. **Cause verified.** The claim is checked against the code, not inferred from a name or the diff alone.
3. **Realistic trigger.** You can say who or what causes it in real use of this code.
   If the trigger needs something that does not happen in practice, drop the finding.
   Example to drop: "two admins run this backfill at the same time" for a script run by hand once.
4. **Introduced by the change.** If not, it goes in the pre-existing section, and only
   if the new code depends on it.

No hypothetical findings. If you suspect something but cannot verify it,
put it under "Things I did not verify". Do not put it in the table.

## 6. Write the doc

Load the `verified-doc` skill. Use its location, file naming, frontmatter, verification rules,
writing rules, and "Things I did not verify" section.
Replace its summary table and per-item sections with the structure below.
Do not use its AGREE/PARTIAL/DISAGREE verdicts or quote callouts.

File name: `PR 100 <short title> review.md` or `<branch> review.md`.
Frontmatter `type: code-review`. `revision` is the reviewed head and the merge-base.

### Findings table

| # | Severity | Category | Location | Affects |
|---|---|---|---|---|
| 1 | **MUST-FIX** | correctness | `apps-api src/billing/invoice.ts:142` | refunds for multi-currency orders |

Severity:
- **MUST-FIX**: a bug, data risk, or broken caller.
- **SHOULD-FIX**: duplication, tests that do not test, design problems with a named consequence.
- **NIT**: comments, naming, small simplifications.

Order by severity, then by file.
Location carries the repo and enough path to be unambiguous, plus a line or line range.

### Per-finding sections

One H3 per row, same number:

```
### 1. MUST-FIX `src/billing/invoice.ts:142-158`

- **Problem:** one line.
- **Trigger:** who or what causes it in real use.
- **Affects:** callers, data, or users, each with file:line.
- **Evidence:** what was read or run.
- **Fix:** one line, or a short diff.
```

Bullets only. No paragraphs. Leave out **Trigger** for NIT.

### Pre-existing issues the change depends on

Same bullet format. Omit the section if empty.

### Things I did not verify

Never omitted. Required by `verified-doc`.

## 7. In chat

Vault path, then the MUST-FIX count and one line per MUST-FIX. Stop there.
