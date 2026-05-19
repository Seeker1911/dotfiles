name: browser
---
description: Use the `browse` cli tool to automate browser interaction with LLM
allowed-tools: Bash(browse:*)
---

# browse cli skill
One CLI for skills, browser primitives, debugging, and cloud sessions, designed to be driven by AI Agents.

## Commands
- Give AI Agents the skills to automate websites from the open web catalog. Suggested DOM selectors and XHR requests cut token costs by 50x.
    * browse skills add [website]

- Drive any page with low-level primitives: click, scroll, type, hover, press. Address elements by selector or by the AI Agent's accessibility refs.
    * browse click "input#search"
    * browse type "Apartments in SF"
    * browse select @8 "Single family unit"
    * browse press "Enter"
    * browse mouse scroll 50 50 10 10
    * browse screenshot

- Tail the network and console of any browse session in real time. AI Agents (and you) see exactly what the page did.
    * browse network --tail
    * browse console --tail

## What This Skill Does
This skill and cli tool allows LLM's to automate website interaction to assisst in development, debugging, discovery

## Prerequisites
the cli tool `browse` should be globally available. If it is not, install with `npm install -g browse`
