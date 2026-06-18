# Control Flow

Functional control flow favors expressions over statements, making code more concise and composable.

## Ternary Operator

Prefer ternaries for simple conditional expressions.

### Basic usage

```typescript
// ❌ If statement
let status;
if (age >= 18) {
  status = 'adult';
} else {
  status = 'minor';
}

// ✅ Ternary expression
const status = age >= 18 ? 'adult' : 'minor';

// ✅ In returns
const getDiscount = (isMember: boolean): number =>
  isMember ? 0.1 : 0;

// ✅ In object properties
const user = {
  name: 'Alice',
  role: isAdmin ? 'admin' : 'user',
  permissions: isPremium ? premiumPerms : basicPerms
};
```

### Nested ternaries

Use for simple chains, but know when to use switch instead.

```typescript
// ✅ Acceptable for 2-3 conditions
const getGrade = (score: number): string =>
  score >= 90 ? 'A' :
  score >= 80 ? 'B' :
  score >= 70 ? 'C' :
  score >= 60 ? 'D' :
  'F';

// ✅ With clear formatting
const getColor = (status: Status): string =>
  status === 'success' ? 'green' :
  status === 'error' ? 'red' :
  status === 'warning' ? 'yellow' :
  'gray';

// ❌ Too complex (use switch or object lookup)
const value = condition1 ?
  (condition2 ? value1 : (condition3 ? value2 : value3)) :
  (condition4 ? value4 : value5);
```

### Null coalescing

```typescript
// Default values
const name = user.name ?? 'Guest';
const port = process.env.PORT ?? 3000;

// Chain multiple
const value = config.override ?? user.preference ?? defaultValue;

// With optional chaining
const city = user?.address?.city ?? 'Unknown';
```

## Switch Statements

Use switch for multiple discrete conditions.

### Basic patterns

```typescript
// ✅ Clean switch with returns
const getIcon = (type: NotificationType): string => {
  switch (type) {
    case 'success': return '✓';
    case 'error': return '✗';
    case 'warning': return '⚠';
    case 'info': return 'ℹ';
    default: return '•';
  }
};

// ✅ With complex logic per case
const processEvent = (event: Event): Result => {
  switch (event.type) {
    case 'click':
      return handleClick(event.target, event.data);

    case 'scroll':
      return handleScroll(event.position);

    case 'resize':
      return handleResize(event.dimensions);

    default:
      return { type: 'unknown', event };
  }
};
```

### Grouped cases

```typescript
const getCategory = (char: string): string => {
  switch (char) {
    case 'a':
    case 'e':
    case 'i':
    case 'o':
    case 'u':
      return 'vowel';

    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      return 'digit';

    default:
      return 'other';
  }
};
```

### Switch expressions (proposed)

```typescript
// TypeScript may support switch expressions in future
// For now, use functions or object lookups
const result = switch (value) {
  case 'a': 1;
  case 'b': 2;
  default: 0;
}; // Not yet valid TS
```

## Object Lookups

Alternative to switch for mappings.

### Simple lookups

```typescript
// ✅ Object as map
const ICONS = {
  success: '✓',
  error: '✗',
  warning: '⚠',
  info: 'ℹ'
} as const;

const getIcon = (type: keyof typeof ICONS) =>
  ICONS[type] ?? '•';

// ✅ With functions
const HANDLERS = {
  click: handleClick,
  scroll: handleScroll,
  resize: handleResize
} as const;

const processEvent = (type: keyof typeof HANDLERS, event: Event) =>
  HANDLERS[type]?.(event) ?? handleDefault(event);
```

### Dynamic lookups

```typescript
// Computed values
const DISCOUNTS: Record<Tier, number> = {
  gold: 0.2,
  silver: 0.1,
  bronze: 0.05
};

const getDiscount = (tier: Tier) => DISCOUNTS[tier] ?? 0;

// With functions that need params
const FORMATTERS: Record<Format, (n: number) => string> = {
  currency: n => `$${n.toFixed(2)}`,
  percent: n => `${(n * 100).toFixed(1)}%`,
  integer: n => n.toFixed(0)
};

const format = (type: Format, value: number) =>
  FORMATTERS[type]?.(value) ?? value.toString();
```

## Early Returns

Use guard clauses to reduce nesting.

```typescript
// ❌ Nested conditions
const processUser = (user: User | null): Result => {
  if (user) {
    if (user.verified) {
      if (user.subscription) {
        return { success: true, data: user };
      } else {
        return { success: false, error: 'No subscription' };
      }
    } else {
      return { success: false, error: 'Not verified' };
    }
  } else {
    return { success: false, error: 'User not found' };
  }
};

// ✅ Guard clauses
const processUser = (user: User | null): Result => {
  if (!user) return { success: false, error: 'User not found' };
  if (!user.verified) return { success: false, error: 'Not verified' };
  if (!user.subscription) return { success: false, error: 'No subscription' };

  return { success: true, data: user };
};
```

## Pattern Matching (Future/Alternative)

TypeScript doesn't have pattern matching yet, but you can simulate it:

```typescript
// Custom pattern matching helper
type Pattern<T, R> = {
  when: (value: T) => boolean;
  then: (value: T) => R;
};

const match = <T, R>(
  value: T,
  patterns: Pattern<T, R>[],
  defaultCase: (value: T) => R
): R => {
  const pattern = patterns.find(p => p.when(value));
  return pattern ? pattern.then(value) : defaultCase(value);
};

// Usage
const getStatus = (code: number) => match(
  code,
  [
    { when: c => c >= 200 && c < 300, then: () => 'success' },
    { when: c => c >= 400 && c < 500, then: () => 'client-error' },
    { when: c => c >= 500, then: () => 'server-error' }
  ],
  () => 'unknown'
);
```

## Conditional Execution

### Short-circuit evaluation

```typescript
// Execute conditionally
isValid && processData();
hasPermission && user.verified && performAction();

// With nullish coalescing
user?.subscription?.active && sendWelcomeEmail(user);

// Default execution
const result = tryPrimary() || trySecondary() || defaultValue;
```

### Maybe pattern

```typescript
type Maybe<T> = T | null | undefined;

const maybeMap = <T, U>(
  value: Maybe<T>,
  fn: (value: T) => U
): Maybe<U> =>
  value != null ? fn(value) : null;

// Usage
const age = maybeMap(user, u => u.age);
const upper = maybeMap(user?.name, n => n.toUpperCase());
```

## Choosing the Right Pattern

### Use ternary when:
- Simple binary condition
- Single expression per branch
- Readable on one or few lines
- Need an expression (not a statement)

### Use switch when:
- 3+ discrete values to check
- Complex logic per case
- Need grouped cases
- Exhaustiveness checking needed

### Use object lookup when:
- Simple value mappings
- Data-driven logic
- Mappings can be shared/exported
- Dynamic key selection

### Use early returns when:
- Multiple validation checks
- Deep nesting otherwise
- Error handling upfront
- Guard clauses make sense

## Anti-Patterns

```typescript
// ❌ Unnecessary ternary
const isValid = condition ? true : false;
// ✅ Direct boolean
const isValid = condition;

// ❌ Ternary for side effects
condition ? doThis() : doThat();
// ✅ If statement
if (condition) doThis();
else doThat();

// ❌ Empty switch case
switch (value) {
  case 'a':
    break; // No logic
  default:
    return value;
}
// ✅ Just use default or early return

// ❌ Switch fall-through without comment
switch (value) {
  case 'a':
    doSomething();
  case 'b': // Falls through - bug or intentional?
    doOther();
}
// ✅ Explicit return or comment
```

## Guidelines

- **Ternary first:** For simple binary conditions
- **Switch for multiple:** 3+ discrete values
- **Object for data:** When logic is data-driven
- **Early returns:** Reduce nesting depth
- **Avoid side effects:** In ternaries and short-circuits
- **Type safety:** Leverage exhaustiveness checking
- **Readability:** Choose the clearest pattern for the situation
