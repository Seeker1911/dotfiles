# Array Methods

Functional array operations replace imperative loops with declarative transformations.

## Core Methods

### map - Transform each element

```typescript
// ❌ Imperative
const names = [];
for (const user of users) {
  names.push(user.name);
}

// ✅ Functional
const names = users.map(user => user.name);

// Complex transformation
const formatted = users.map(user => ({
  id: user.id,
  displayName: `${user.firstName} ${user.lastName}`,
  isActive: user.status === 'active'
}));
```

### filter - Select elements

```typescript
// ❌ Imperative
const adults = [];
for (const user of users) {
  if (user.age >= 18) {
    adults.push(user);
  }
}

// ✅ Functional
const adults = users.filter(user => user.age >= 18);

// Multiple conditions
const eligibleUsers = users.filter(user =>
  user.age >= 18 && user.verified && !user.suspended
);

// Type narrowing with type predicate
const isActive = (user: User): user is ActiveUser =>
  user.status === 'active';

const activeUsers = users.filter(isActive); // Type: ActiveUser[]
```

### reduce - Aggregate values

```typescript
// Sum
const total = prices.reduce((sum, price) => sum + price, 0);

// Group by key
const byCategory = products.reduce((acc, product) => ({
  ...acc,
  [product.category]: [...(acc[product.category] ?? []), product]
}), {} as Record<string, Product[]>);

// Build complex structure
const userMap = users.reduce((map, user) => ({
  ...map,
  [user.id]: { ...user, lastSeen: Date.now() }
}), {} as Record<string, User>);

// Count occurrences
const counts = items.reduce((acc, item) => ({
  ...acc,
  [item]: (acc[item] ?? 0) + 1
}), {} as Record<string, number>);
```

## Chaining Operations

```typescript
// ✅ Readable pipeline
const result = users
  .filter(user => user.active)
  .map(user => user.orders)
  .flat()
  .filter(order => order.total > 100)
  .map(order => order.total)
  .reduce((sum, total) => sum + total, 0);

// ✅ Extract steps for clarity
const activeUsers = users.filter(user => user.active);
const allOrders = activeUsers.flatMap(user => user.orders);
const largeOrders = allOrders.filter(order => order.total > 100);
const revenue = largeOrders.reduce((sum, o) => sum + o.total, 0);
```

## Advanced Methods

### find / findLast

```typescript
// Find first match
const admin = users.find(user => user.role === 'admin');

// With default
const admin = users.find(user => user.role === 'admin') ?? defaultAdmin;

// findLast for reverse search (ES2023)
const lastOrder = orders.findLast(o => o.status === 'completed');
```

### some / every

```typescript
// Any match
const hasAdmin = users.some(user => user.role === 'admin');

// All match
const allVerified = users.every(user => user.verified);

// Complex conditions
const hasActiveSubscription = users.some(user =>
  user.subscriptions.some(sub => sub.active && sub.tier === 'premium')
);
```

### flatMap

```typescript
// ❌ Map then flatten
const allTags = posts.map(post => post.tags).flat();

// ✅ FlatMap
const allTags = posts.flatMap(post => post.tags);

// Conditional inclusion
const results = items.flatMap(item =>
  item.valid ? [processItem(item)] : []
);
```

### toSorted / toReversed (ES2023)

```typescript
// ❌ Mutating
const sorted = [...items].sort((a, b) => a.priority - b.priority);

// ✅ Immutable
const sorted = items.toSorted((a, b) => a.priority - b.priority);
const reversed = items.toReversed();
```

## Performance Considerations

```typescript
// ❌ Multiple passes
const result = data
  .filter(x => x.active)
  .map(x => x.value)
  .filter(x => x > 10)
  .map(x => x * 2);

// ✅ Combined logic (when performance matters)
const result = data
  .filter(x => x.active && x.value > 10)
  .map(x => x.value * 2);

// ✅ Early termination with find
const found = items.find(item => expensiveCheck(item)); // Stops when found

// ❌ Processes all items
const found = items.filter(item => expensiveCheck(item))[0];
```

## Common Patterns

### Partition

```typescript
const partition = <T>(arr: T[], predicate: (item: T) => boolean) => ({
  pass: arr.filter(predicate),
  fail: arr.filter(item => !predicate(item))
});

const { pass: adults, fail: minors } = partition(
  users,
  user => user.age >= 18
);
```

### GroupBy (using reduce)

```typescript
const groupBy = <T, K extends string | number>(
  arr: T[],
  key: (item: T) => K
): Record<K, T[]> =>
  arr.reduce((acc, item) => {
    const k = key(item);
    return { ...acc, [k]: [...(acc[k] ?? []), item] };
  }, {} as Record<K, T[]>);

const byStatus = groupBy(orders, order => order.status);
```

### Unique values

```typescript
const unique = <T>(arr: T[]): T[] => [...new Set(arr)];

// By property
const uniqueBy = <T, K>(arr: T[], key: (item: T) => K): T[] =>
  [...new Map(arr.map(item => [key(item), item])).values()];

const uniqueUsers = uniqueBy(users, user => user.email);
```

## Guidelines

- **Chain for clarity:** Multiple small steps beats one complex loop
- **Avoid mutations:** Never modify the array being iterated
- **Consider performance:** For large datasets, minimize passes
- **Use type predicates:** Enable type narrowing with filter
- **Prefer flatMap:** Over map + flat
