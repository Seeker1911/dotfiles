---
name: verified-doc
description: Write a detailed, claim-by-claim verified document into the Obsidian vault. Use whenever the user asks for a doc, write-up, report or response that needs each point checked against source, in any repo or none. Covers responses to PR review comments, audits of code or data, reviews of someone else's pitch or design doc, incident analysis, and checking a set of claims against what the code actually does. Trigger on "write it up", "put it in a doc", "check every comment", "verify this", "review this and give me a document".
compatibility: All
user-invocable: true
allowed-tools: Write(//Users/michaelmead/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/Claude Docs/**)
---

# Verified document

The reader is the user, days later, with no memory of this session.
The document has to stand alone, lead with what changes their next action,
and let them check every claim without asking.

## Where it goes

Markdown only. One file in:

```
/Users/michaelmead/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/Claude Docs/
```

File name is a human title in sentence case, no date, no slug:
`PR 908 Wagner review response.md`, `Billing webhook drift audit.md`.
The date lives in frontmatter.

Never write it anywhere else unless the user names a location.
Never write HTML for this. The user edits these in Obsidian in vim mode.

## Before writing: verify

Every claim in the document is checked against source in this session.
Nothing is asserted from memory, from a design doc, or from a previous note
without re-reading the code or data it describes.

- Name the exact revision checked: `repo@sha`, branch, or file timestamp.
- For "before" and "after" statements, diff against the named base. Never infer what the base did.
- For "pre-existing" claims, prove it with `git log`, `git show <base>:<path>`, or blame. Say which.
- For "no consumer" or "unused" claims, grep every repo that could consume it and name them.
  A symbol with zero references in one repo is a hypothesis, not a finding.
- For a claim about a dependency's capability, read the dependency's routes, models or schema. Cite the file.
- When a shared function is touched, enumerate every caller and say what each one needs.
- If you cannot verify something, it goes in the final section, not in the body as if it were verified.

Read memory notes for context on decisions, then verify them anyway.
A memory says what was true when written.

## Structure

Sections in this order. Omit a section only where noted.

### Frontmatter

```yaml
---
title: <same as the H1>
date: <YYYY-MM-DD>
type: review-response | audit | doc-review | incident | claim-check
repo: <primary repo, or none>
revision: <repo@sha or equivalent>
tags: [claude-doc, <topic tags>]
---
```

### H1 and scope line

One H1. Then two to four lines stating what was reviewed, when, and against which
revisions. This is where every `repo@sha` is named once.

### Act-first block

A `> [!warning]` callout, only if something in the review changes what the reader
does before anything else: a contradiction they must fix, a regression they must
check, a decision that blocks the rest. Bold the first phrase of each item.
Omit the block entirely when nothing qualifies. Do not fill it to have one.

### Summary table

One row per item under review. Columns: `#`, `Where`, `Their point` (or `Claim`),
`Verdict`, `Action`. Verdict is one of three words in bold caps, with an optional
qualifier after a comma:

- **AGREE**
- **PARTIAL**
- **DISAGREE**

Qualifiers that have earned their place: `pre-existing`, `misread`, `out of scope`,
`on facts`, `with context`. Invent one only when none fits.

After the table, if three or more items share one root argument, say so in one
sentence and name them. Then answer that argument once in its own H2 before the
per-item sections, and have each item point back to it.

### Per-item sections

One H3 per item, numbered to match the table. Heading names the repo and path
with line when it applies:

```
### 7. apps-backend-mono `src/modules/users/repositories/user.ts:149`
```

Inside, in this order:

1. `> [!quote] <author>` callout with their words verbatim. Never paraphrase the thing being answered.
2. **What the code does.** Bullets. Each bullet carries its evidence: file, line, commit, command run.
   State explicitly whether the thing is introduced by the change or pre-existing, and how you know.
3. **Where they are right**, if anything. Concede specifically. A weak reason in our own design doc is named as weak.
4. **Options**, only when the verdict is PARTIAL and a code change is on the table. Each with its cost.
5. `> [!tip] Suggested reply` callout, only when a reply to a person is expected.
   Written in the user's voice, first person, ready to paste, no hedging, no thanks.

### Recommended actions

Bulleted. Bold the first words. Each is a concrete thing the reader does:
apply, decide, fix a line, ticket a follow-up, ask a named owner for a look.

### Things I did not verify

Never omitted. Never empty. If you believe everything was verified, list what
you did not look at: logs, other consumers, conversations referenced, environments not checked.

## Writing rules

These are the rules that made the format work. They are not optional.

- Every file mention carries the repo and enough path to be unambiguous. `user.ts` alone is never enough.
  Inside a section already headed with a repo, the path alone is fine.
- Plain language. Say what a thing is. No invented names for things found during the session.
- No emojis anywhere.
- Short lines in the source. Break at sentence or clause boundaries so the file diffs and edits cleanly in vim.
- Numbers that change a decision go on their own line or in a table, not buried in prose.
- Short code goes in inline code. Diffs and commands go in fenced blocks. A diff of the exact lines under
  dispute is often the whole answer; use one when a comment misreads a change.
- No closing summary paragraph. The document ends at the last section.

## In chat, after writing

Give the vault path, then the act-first items in one or two sentences each, then stop.
Do not restate the document. The user will read it days later; the chat message is
only there to tell them it exists and whether anything is urgent.
