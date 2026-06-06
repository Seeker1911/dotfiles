# TypeScript Functional Programming

Expert guidance on functional programming patterns in TypeScript. Use when writing TypeScript code that emphasizes pure functions, immutability, composition, and declarative style. Prevents common imperative anti-patterns and promotes concise, maintainable code.

## Principles

- **Pure functions:** No side effects, deterministic outputs
- **Immutability:** Data never mutates, create new values instead
- **Composition:** Build complex functions from simple ones
- **Declarative:** Express what to do, not how to do it
- **Conciseness:** Minimize boilerplate, maximize clarity

## Style Guide

### Prefer

- Ternary operators over if statements for simple conditionals
- Switch statements over if/else chains for multiple conditions
- Array methods (map, filter, reduce) over for loops
- Function expressions over function statements
- `const` over `let`, never use `var`
- Expression-based code over statement-based
- Early returns for guard clauses

### Avoid

- Mutations of variables or objects
- For/while loops when array methods work
- Nested conditionals
- Multi-line if statements for simple logic
- Side effects in functions (prefer explicit effect handling)

## Structure

- `SKILL.md` - Main skill instructions and quick reference
- `references/` - Detailed documentation for specific patterns
- `examples/` - TypeScript code examples demonstrating patterns

## Usage

This skill is automatically discovered by Claude when working with TypeScript or when functional programming patterns are relevant to the task.
