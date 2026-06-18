# Immutability

Immutable data prevents bugs from unexpected mutations and makes code easier to reason about.

## Core Principles

1. **Never modify:** Create new values instead of changing existing ones
2. **Structural sharing:** Reuse unchanged parts for efficiency
3. **Const by default:** Use `const` unless mutation is truly needed
4. **Spread operators:** Primary tool for immutable updates

## Objects

### Simple updates

```typescript
// ❌ Mutation
user.age = 30;
user.verified = true;

// ✅ Immutable update
const updated = { ...user, age: 30, verified: true };

// Multiple levels
const updated = {
  ...user,
  address: {
    ...user.address,
    city: 'New York'
  }
};
```

### Nested updates

```typescript
// Helper for deep updates
const updateNested = <T>(obj: T, path: string[], value: any): T => {
  const [head, ...rest] = path;
  return !head
    ? value
    : { ...obj, [head]: updateNested((obj as any)[head], rest, value) };
};

// Usage
const updated = updateNested(user, ['address', 'city'], 'Boston');

// Or use libraries like immer for complex cases
import produce from 'immer';

const updated = produce(user, draft => {
  draft.address.city = 'Boston'; // Safe mutation in draft
});
```

### Removing properties

```typescript
// ❌ Mutation
delete user.temporaryToken;

// ✅ Destructuring
const { temporaryToken, ...userWithoutToken } = user;

// Multiple properties
const { temp, cache, debug, ...cleaned } = data;
```

### Conditional properties

```typescript
// Add property conditionally
const user = {
  name: 'Alice',
  age: 30,
  ...(isAdmin && { role: 'admin' }),
  ...(hasPremium && { tier: 'premium' })
};

// Merge conditionally
const updated = {
  ...user,
  ...(changes.email && { email: changes.email }),
  ...(changes.phone && { phone: changes.phone })
};
```

## Arrays

### Adding elements

```typescript
// ❌ Mutation
arr.push(item);
arr.unshift(item);

// ✅ Immutable
const withItem = [...arr, item];
const withItemAtStart = [item, ...arr];

// Insert at position
const insertAt = <T>(arr: T[], index: number, item: T): T[] => [
  ...arr.slice(0, index),
  item,
  ...arr.slice(index)
];
```

### Removing elements

```typescript
// ❌ Mutation
arr.splice(index, 1);
arr.pop();
arr.shift();

// ✅ Immutable
const without = arr.filter((_, i) => i !== index);
const withoutLast = arr.slice(0, -1);
const withoutFirst = arr.slice(1);

// Remove by value
const without = arr.filter(item => item.id !== targetId);
```

### Updating elements

```typescript
// ❌ Mutation
arr[index] = newValue;

// ✅ Immutable
const updated = arr.map((item, i) =>
  i === index ? newValue : item
);

// Update by condition
const updated = arr.map(item =>
  item.id === targetId ? { ...item, status: 'active' } : item
);

// Update multiple
const updated = arr.map(item =>
  itemsToUpdate.includes(item.id)
    ? { ...item, processed: true }
    : item
);
```

### Sorting

```typescript
// ❌ Mutation
arr.sort((a, b) => a - b);

// ✅ Immutable (ES2023)
const sorted = arr.toSorted((a, b) => a - b);

// ✅ Immutable (older)
const sorted = [...arr].sort((a, b) => a - b);

// Multiple sort keys
const sorted = users.toSorted((a, b) =>
  a.lastName.localeCompare(b.lastName) ||
  a.firstName.localeCompare(b.firstName)
);
```

### Reversing

```typescript
// ❌ Mutation
arr.reverse();

// ✅ Immutable (ES2023)
const reversed = arr.toReversed();

// ✅ Immutable (older)
const reversed = [...arr].reverse();
```

## Common Patterns

### Toggle in array

```typescript
const toggleItem = <T>(arr: T[], item: T): T[] =>
  arr.includes(item)
    ? arr.filter(x => x !== item)
    : [...arr, item];

// Usage
const selected = toggleItem(selectedIds, userId);
```

### Update or insert

```typescript
const upsert = <T extends { id: string }>(
  arr: T[],
  item: T
): T[] => {
  const index = arr.findIndex(x => x.id === item.id);
  return index >= 0
    ? arr.map((x, i) => i === index ? item : x)
    : [...arr, item];
};
```

### Merge arrays

```typescript
// Concatenate
const merged = [...arr1, ...arr2];

// Unique values
const unique = [...new Set([...arr1, ...arr2])];

// Merge objects by key
const mergeById = <T extends { id: string }>(
  arr1: T[],
  arr2: T[]
): T[] => {
  const map = new Map([...arr1, ...arr2].map(x => [x.id, x]));
  return [...map.values()];
};
```

## Records/Maps

### Object as map

```typescript
// ❌ Mutation
map[key] = value;
delete map[key];

// ✅ Immutable
const updated = { ...map, [key]: value };
const removed = Object.fromEntries(
  Object.entries(map).filter(([k]) => k !== key)
);

// Bulk update
const updated = {
  ...map,
  ...Object.fromEntries(items.map(item => [item.id, item]))
};
```

### Map data structure

```typescript
// Use Map when keys are dynamic
const map = new Map(entries);

// ❌ Mutation
map.set(key, value);
map.delete(key);

// ✅ Immutable
const updated = new Map([...map, [key, value]]);
const removed = new Map([...map].filter(([k]) => k !== key));

// Convert to object
const obj = Object.fromEntries(map);
```

## TypeScript Helpers

### Readonly types

```typescript
// Prevent mutations at type level
type User = {
  readonly id: string;
  readonly email: string;
  name: string; // Mutable
};

// Deep readonly
type DeepReadonly<T> = {
  readonly [K in keyof T]: T[K] extends object
    ? DeepReadonly<T[K]>
    : T[K];
};

// Use as const for literals
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000
} as const; // Type is readonly
```

### Immutable utilities

```typescript
// Set property immutably
const set = <T, K extends keyof T>(obj: T, key: K, value: T[K]): T => ({
  ...obj,
  [key]: value
});

// Update with function
const update = <T, K extends keyof T>(
  obj: T,
  key: K,
  fn: (value: T[K]) => T[K]
): T => ({
  ...obj,
  [key]: fn(obj[key])
});

// Usage
const user2 = set(user, 'age', 31);
const user3 = update(user, 'age', age => age + 1);
```

## Performance

### Structural sharing

```typescript
// Only changed parts are new
const original = { name: 'Alice', age: 30, address: { city: 'NYC' } };
const updated = { ...original, age: 31 };

// original.address === updated.address (same reference)
// Only age property is new
```

## Guidelines

- **Const by default:** Only use `let` when truly needed
- **Spread for shallow:** Use spread operator for one level deep
- **Readonly types:** Add readonly to prevent accidental mutations
- **Share structure:** Let JavaScript reuse unchanged parts
- **Profile first:** Optimize only if performance is actually an issue
