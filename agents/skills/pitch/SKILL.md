---
description: Write a pitch meeting document based on outcomes from feature planning with user
compatibility: All
user-invocable: true
allowed-tools: Bash(mcp:*),  Write(//Users/michaelmead/Documents/**)
skills: /peek-pitch
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

## implementation
use the peek-pitch skill for rules on the document writing.


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
