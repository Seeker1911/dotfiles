---
description: Write a pitch meeting document based on outcomes from feature planning with user
compatibility: All
user-invocable: true
allowed-tools: Bash(mcp:*),  Write(//Users/michaelmead/Documents/**)
---

# Write a pitch skill

Upon request by the user to enable this skill, ask the user what we are planning.

## Plan phase
Use the plan skill to decide on requirements for a feature
Use the /grill-me skill to drill down on decisions with the developer until there is absolute mutual understanding.
Dont default to very long output in examples and responses, information is easily missed that way.

## Write phase
Create a Markdown document in ~/Documents/Obsidian Vault/Work/Peek/[title.md]
Recommended length: 1–3 pages of core content (~700-2,400 words)
The document should not take longer than 10-15 minutes to read
The document is technical in nature but not technical implementation. It should contain enough info to inform any developer that is assigned 
on what to do, not how to implement. It generally should not contain code blocks except when informing a contract between functional components, backend/frontend for example.
It should be technical enough to impress the CTO while written with enough prose to satisfy a product owner.

## Audience
engineering leads, product, technical executives

# Critical, the format must contain the following sections
1. Task / Story

What is being proposed, in one or two sentences. Link to the ticket(s) or project tracker.

2. Goal

The product goal this work serves. Not "what we're building" — why we're building it. What changes for the customer, the business, or the product when this is done? What does success look like, and how will we know we hit it (metrics, observable outcomes)?

3. Non-Technical Explanation

A plain-language description of what needs to happen to achieve the goal, written so that a product partner or non-engineer can follow it end-to-end. 

Include:

The user-facing or business-facing flow.

The major pieces of work and the order they need to happen in.

Dependencies on other stories, tasks, teams, or systems — name the work, name the owner, and state what would happen if that dependency slipped.

4. Technical Details

Enough technical depth that another engineer can see a clear roadmap to get this done and can help identify gaps. This typically includes:



The approach and key design decisions, and the alternatives that were considered and rejected.

Data model, API surface, or system boundaries that change.

Migration, rollout, or backfill plans where relevant.

Testing and observability plan.

5. Risks and Mitigations

The things most likely to go wrong, and what the engineer plans to do about each. Be specific. "Unknown unknowns" is not a risk — name the actual concerns: integration risk with X, performance under Y load, the third-party API we depend on, the teammate who is also touching this code, etc. For each risk, state the mitigation and the trigger that would cause us to invoke it.

6. Assumptions/Dependencies

The things that must be true for this plan to work, but which are not stated goals of the project. These are load-bearing claims, not risks — risks are things we plan to mitigate; assumptions are things we are relying on.
Examples:

"Team X ships their new API by [date],"

"I am using technology X because it is the only way to do this work"

"In the future we need to do X to scale to Y"

"we keep the current auth model through Q3,"

"the third-party integration's rate limit doesn't change."

If an assumption turns out to be wrong, the plan needs to be revisited — surfacing it here makes these decisions easier to spot later.

7. Timeline

A dated timeline, not a vibes-based one. Include:

Milestones inside the project, with effort in time.

The people assigned to each milestone of this story, by name. Where this story depends on another story landing first, include the date you are committing to for the dependency

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
