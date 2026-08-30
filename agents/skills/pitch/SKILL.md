---
description: Write a pitch meeting document based on outcomes from feature planning with user
compatibility: All
user-invocable: true
allowed-tools: Bash(mcp:*),  Write(//Users/michaelmead/Documents/**)
---

# Write a pitch skill

Upon request by the user to enable this skill, ask the user what we are planning.

Reference: "Making Our Pitches More Effective" (CTO, 2026-08)
https://piiq.atlassian.net/wiki/spaces/Eng/pages/1046151200/Making+Our+Pitches+More+Effective
The bar it sets: about 80% of the real risks and real goals are found BEFORE the meeting is
scheduled. The meeting is for the last 20%. A pitch that builds alignment in the room has
already failed.

## Plan phase
Use the plan skill to decide on requirements for a feature
Use the /grill-me skill to drill down on decisions with the developer until there is absolute mutual understanding.
Dont default to very long output in examples and responses, information is easily missed that way.

Before writing, establish these three things. Ask if they are not known.
1. What the business priority is right now. Not the author's next task, the top priority.
2. When Product needs it and why. A real reason: a customer, a contract, a launch.
   If there is no business date, write that there is none. Never invent one.
3. The success metric, its value today, and its target. Measure the baseline before writing.

## Write phase
Create a Markdown document in /Users/michaelmead/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Vault/Work/Peek
Recommended length: 1–3 pages of core content (~700-2,400 words)
The document should not take longer than 10-15 minutes to read
The document is technical in nature but not technical implementation. It should contain enough info to inform any developer that is assigned
on what to do, not how to implement. It generally should not contain code blocks except when informing a contract between functional components, backend/frontend for example.
It should be technical enough to impress the CTO while written with enough prose to satisfy a product owner.

What this skill produces is a draft in the right shape. It has not seen the author's system,
dependencies or real risks. Say so when handing it over. It is the start of the work, not the end.

## Audience
engineering leads, product, technical executives

# Critical, the format must contain the following sections
1. Task / Story

What is being proposed, in one or two sentences. Link to the ticket(s) or project tracker.

2. Goal

The product goal this work serves. Not "what we're building" — why we're building it. What changes for the customer, the business, or the product when this is done?
Dont start with the solution, start with the problem.

Success must be a number, not a description. State the metric, where it stands today, where it
has to get to, and by when. "The feature works" is not success. A target with no baseline behind
it is not a target. The number is not a report card, it is what tells you which solution to build
and which scope is safe to cut, so use it while planning rather than adding it at the end.

State the business priority and the business timing here. If Product has a date, give it and the
reason behind it. If there is no date, say there is none.

3. Non-Technical Explanation

A plain-language description of what needs to happen to achieve the goal, written so that a product partner or non-engineer can follow it end-to-end.

Include:

The user-facing or business-facing flow.

The major pieces of work and the order they need to happen in.

Dependencies on other stories, tasks, teams, or systems — name the work, name the owner, and state what would happen if that dependency slipped. A missing design, decision or upstream
team is named here, never quietly worked around. If something was asked for and not received,
that is stated, not absorbed.

4. Technical Details

Enough technical depth that another engineer can see a clear roadmap to get this done and can help identify gaps. This typically includes:

The approach and key design decisions, and the alternatives that were considered and rejected.

Data model, API surface, or system boundaries that change.

Migration, rollout, or backfill plans where relevant.

Testing and observability plan.

5. Risks and Mitigations

Risks should not be something true of all software ("the code may fail", "AWS may go down") or a task we already planned to do.
The risks that matter, the ones caused by a decision we made in the plan, that could stop us from succeeding, now or later, are the risks we care about. These may be product related risks or technical risks.

Walk what was chosen, what was skipped, and what was left for later. For each one state four
things: what it costs, who pays it, when they pay it, and what you want done about it. A risk
nobody can act on is not a risk. A thing you are simply relying on is an assumption, so it
belongs in section 6. If you asked for something you needed and did not get it, that is a risk
and it goes here.

6. Assumptions/Dependencies

The things that must be true for this plan to work, but which are not stated goals of the project. These are load-bearing claims, not risks — risks are things we plan to mitigate; assumptions are things we are relying on.
Examples:

"Team X ships their new API by [date],"

"I am using technology X because it is the only way to do this work"

"In the future we need to do X to scale to Y"

"we keep the current auth model through Q3,"

"the third-party integration's rate limit doesn't change."

If an assumption turns out to be wrong, the plan needs to be revisited — surfacing it here makes these decisions easier to spot later.

7. Work-streams and Effort

Never write calendar dates. We do not know when the work starts, and an invented start date is
worse than no date. Size in effort and sequence relatively.

Break the project into work-streams. A work-stream is a piece of work with a clean boundary
that can be owned and sized on its own. Each one gets: the boundary, the effort, what it depends
on, and whether it can run in parallel with the others. Breaking them out is what shows the real
size of the work and what lets someone else pick up a piece.

Do not name individual developers. That is this author's standing convention. But the staffing
gap must still be visible: state how many work-streams can run in parallel and how many people
that needs. If there are more work-streams than people available, say so plainly. Never quietly
plan for one person to carry all of them, and never fold one work-stream into another to make
the gap disappear.

Express effort in days per work-stream and give a total calendar range for a stated number of
people. Relative sequencing only: "second week", "after the flag flip", "parallel with X".

Sizing discipline: a pitch should describe work that fits in about 2 to 3 weeks in total,
including testing, PR review and deployment. If the plan comes out larger than that, the scope
is wrong or it is more than one pitch. Cut it or split it, and say which. Do not pad estimates,
and do not inflate a milestone to look thorough.

Knowing the available time is not a reason to cut correct work. It is how the right solution
gets chosen in the first place. When the effort and the business timing do not agree, say so
plainly in this section. That disagreement is the single most useful thing to bring into the room.

## Common structural patterns to avoid
* Heavy use of bullet lists: Most of the piece is short bullets instead of developed paragraphs with examples or nuance.
* Many similar subheadings: Every couple of paragraphs has a heading like “Understanding X,” “The Importance of Y,” “The Future of Z.” Sections feel interchangeable.
* Standard essay frame: General intro that announces the topic, three body sections that mirror that sentence, then a recap that restates each heading.
* Strong signposting everywhere: Frequent lines like “Now that we’ve explored X…”, “As mentioned earlier…”, “In the next section, we will discuss…”, even when the connection is obvious.
* Same-sized paragraphs: Most paragraphs have similar length and follow the same pattern: definition, explanation, hedge, small summary. Pace barely changes.
* Writing about the article instead of the topic: “In this section, we’ll look at…”, “First, we will examine… then we will explore…”.
* Generic over-simplified examples: “For example, businesses can use AI to streamline workflows and improve outcomes.” This kind of example is technically correct, but so generic it adds no information. It could appear in almost any AI article, which is exactly why readers recognize it as machine-generated.
* Generic conclusion: A final paragraph that zooms out to a safe, high-level statement (“As AI continues to evolve…”) without adding anything specific.

## Special instructions
* The plan tells us what is being built, why, and how. Enough that someone else could pick it up and execute it.
* Do not use emdashes or overuse colons
* Be clear and concise
* Use active voice
* Put the most important information first
* Include relevant links and references
* Do not draw diagrams or use emojis
* Avoid this "banned list"  of words to immediately improve the output:
    Delve, Unlock, Gating/Gated, Tapestry, Paradigm, Cutting-edge, Revolutionize, Landscape, Potential, Intricate, Meticulously, Vibrant, Unparalleled, Underscore, Leverage, Synergy, Groundbreaking, Holistic, Garner, Pioneering, Transformative, Seamless, Robust.
