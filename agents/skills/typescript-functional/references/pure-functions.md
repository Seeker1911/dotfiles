# Pure Functions

Pure functions are the foundation of functional programming. They have no side effects and return the same output for the same input.

## Characteristics

1. **Deterministic:** Same input → same output
2. **No side effects:** Doesn't modify external state
3. **No mutations:** Doesn't modify arguments
4. **Referentially transparent:** Can be replaced with its return value

## Examples

### ✅ Pure Functions

```typescript
// Simple pure function
const add = (a: number, b: number): number => a + b;

// Pure function with objects (no mutation)
const updateUser = (user: User, age: number): User => ({
  ...user,
  age,
  updatedAt: Date.now()
});

// Pure function with arrays
const addItem = <T>(arr: T[], item: T): T[] => [...arr, item];

// Pure computation
const calculateDiscount = (price: number, tier: Tier): number => {
  const rates = { gold: 0.2, silver: 0.1, bronze: 0.05 };
  return price * (1 - (rates[tier] ?? 0));
};
```

### ❌ Impure Functions

```typescript
// Modifies external state
let count = 0;
const increment = () => count++; // Side effect!

// Mutates argument
const sortItems = (items: Item[]) => {
  items.sort(); // Mutates input!
  return items;
};

// Non-deterministic (depends on time)
const greet = (name: string) =>
  `Hello ${name} at ${new Date()}`; // Different each call

// I/O operations
const saveUser = (user: User) => {
  localStorage.setItem('user', JSON.stringify(user)); // Side effect!
};
```

## Handling Side Effects

Side effects are necessary, but isolate them:

```typescript
// ✅ Separate pure logic from effects
const calculateTotal = (items: Item[]): number =>
  items.reduce((sum, item) => sum + item.price, 0);

const saveOrder = (order: Order): void => {
  const total = calculateTotal(order.items); // Pure
  api.post('/orders', { ...order, total }); // Effect isolated
};

// ✅ Return data for effects, don't perform them
const prepareEmail = (user: User): Email => ({
  to: user.email,
  subject: 'Welcome!',
  body: `Hello ${user.name}`
});

// Caller handles effect
const email = prepareEmail(user);
emailService.send(email); // Effect happens here
```

## Testing

Pure functions are trivial to test:

```typescript
// No mocking, no setup, no cleanup needed
describe('calculateDiscount', () => {
  it('applies gold discount', () => {
    expect(calculateDiscount(100, 'gold')).toBe(80);
  });

  it('applies no discount for unknown tier', () => {
    expect(calculateDiscount(100, 'platinum')).toBe(100);
  });
});
```

## Common Pitfalls

```typescript
// ❌ Hidden mutation
const addToCart = (cart: Cart, item: Item): Cart => {
  cart.items.push(item); // Mutates!
  return cart;
};

// ✅ Return new object
const addToCart = (cart: Cart, item: Item): Cart => ({
  ...cart,
  items: [...cart.items, item]
});

// ❌ Reference to external state
const config = { tax: 0.1 };
const addTax = (price: number) => price * (1 + config.tax);

// ✅ Pass dependencies explicitly
const addTax = (price: number, taxRate: number) =>
  price * (1 + taxRate);
```

## Guidelines

- **Default to pure:** Start with pure functions, add effects only when needed
- **Small functions:** Easier to keep pure and reason about
- **Explicit dependencies:** All inputs as parameters
- **Immutable returns:** Never modify and return the same object
- **Isolate effects:** Push side effects to boundaries (API, storage, etc.)
