# Function Composition

Composition builds complex functions from simple ones, creating reusable, testable building blocks.

## Basic Composition

### Pipe - Left to right data flow

```typescript
// Pipe utility
const pipe = <T>(...fns: ((arg: T) => T)[]) =>
  (value: T) => fns.reduce((acc, fn) => fn(acc), value);

// Usage
const processUser = pipe(
  trimWhitespace,
  toLowerCase,
  validateEmail,
  normalizePhone
);

const cleaned = processUser(userInput);
```

### Compose - Right to left (mathematical)

```typescript
// Compose utility
const compose = <T>(...fns: ((arg: T) => T)[]) =>
  (value: T) => fns.reduceRight((acc, fn) => fn(acc), value);

// Same as pipe but reversed order
const processUser = compose(
  normalizePhone,
  validateEmail,
  toLowerCase,
  trimWhitespace
);
```

## Practical Patterns

### Transform pipelines

```typescript
// Individual transformations
const addVAT = (price: number): number => price * 1.2;
const applyDiscount = (rate: number) => (price: number): number =>
  price * (1 - rate);
const roundTo = (decimals: number) => (n: number): number =>
  Math.round(n * 10 ** decimals) / 10 ** decimals;

// Composed pricing
const calculatePrice = (discount: number) => pipe(
  addVAT,
  applyDiscount(discount),
  roundTo(2)
);

const finalPrice = calculatePrice(0.1)(100); // 108.00
```

### Data transformation

```typescript
type Raw = { name: string; age: string; email: string };
type User = { name: string; age: number; email: string; verified: boolean };

const parseAge = (user: Raw) => ({
  ...user,
  age: parseInt(user.age, 10)
});

const addVerified = (user: Omit<User, 'verified'>) => ({
  ...user,
  verified: user.email.includes('@company.com')
});

const transformUser = pipe(
  parseAge,
  addVerified
);

const user: User = transformUser(rawData);
```

## Higher-Order Functions

Functions that take or return functions.

### Partial application

```typescript
// Generic currying
const curry = <A, B, C>(fn: (a: A, b: B) => C) =>
  (a: A) => (b: B) => fn(a, b);

// Usage
const multiply = (a: number, b: number) => a * b;
const double = curry(multiply)(2);
const triple = curry(multiply)(3);

double(5); // 10
triple(5); // 15

// Practical example
const greet = (greeting: string) => (name: string) =>
  `${greeting}, ${name}!`;

const sayHello = greet('Hello');
const sayHi = greet('Hi');

sayHello('Alice'); // "Hello, Alice!"
sayHi('Bob'); // "Hi, Bob!"
```

### Function factories

```typescript
// Create specialized functions
const createValidator = <T>(
  predicate: (value: T) => boolean,
  message: string
) => (value: T): { valid: boolean; message?: string } =>
  predicate(value)
    ? { valid: true }
    : { valid: false, message };

const isEmail = createValidator(
  (s: string) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s),
  'Invalid email format'
);

const isAdult = createValidator(
  (age: number) => age >= 18,
  'Must be 18 or older'
);

// Create processors
const createMapper = <T, U>(transform: (item: T) => U) =>
  (items: T[]): U[] => items.map(transform);

const uppercaseNames = createMapper((user: User) =>
  user.name.toUpperCase()
);
```

### Decorators (function wrappers)

```typescript
// Add logging
const withLogging = <T extends any[], R>(
  fn: (...args: T) => R,
  name: string
) => (...args: T): R => {
  console.log(`[${name}] Called with:`, args);
  const result = fn(...args);
  console.log(`[${name}] Returned:`, result);
  return result;
};

const add = (a: number, b: number) => a + b;
const loggedAdd = withLogging(add, 'add');

// Add caching
const memoize = <T extends any[], R>(fn: (...args: T) => R) => {
  const cache = new Map<string, R>();
  return (...args: T): R => {
    const key = JSON.stringify(args);
    return cache.has(key)
      ? cache.get(key)!
      : (cache.set(key, fn(...args)), cache.get(key)!);
  };
};

const slowFibonacci = (n: number): number =>
  n <= 1 ? n : slowFibonacci(n - 1) + slowFibonacci(n - 2);

const fastFibonacci = memoize(slowFibonacci);
```

## Point-Free Style

Omit unnecessary parameters by composing functions.

```typescript
// ❌ Pointed (explicit parameters)
const doubleAll = (numbers: number[]) => numbers.map(n => n * 2);
const getNames = (users: User[]) => users.map(u => u.name);

// ✅ Point-free (parameters implicit)
const double = (n: number) => n * 2;
const doubleAll = (numbers: number[]) => numbers.map(double);

const getName = (user: User) => user.name;
const getNames = (users: User[]) => users.map(getName);

// More examples
const sum = (nums: number[]) => nums.reduce((a, b) => a + b, 0);
const isEven = (n: number) => n % 2 === 0;
const filterEven = (nums: number[]) => nums.filter(isEven);

// Chain point-free
const sumEven = (nums: number[]) => pipe(
  (n: number[]) => filterEven(n),
  sum
)(nums);
```

## Practical Composition

### Validation pipeline

```typescript
type Validator<T> = (value: T) => string | null;

const composeValidators = <T>(...validators: Validator<T>[]) =>
  (value: T): string | null =>
    validators.reduce<string | null>(
      (error, validator) => error ?? validator(value),
      null
    );

const required: Validator<string> = v =>
  v.trim() ? null : 'Required';

const minLength = (min: number): Validator<string> => v =>
  v.length >= min ? null : `Minimum ${min} characters`;

const validatePassword = composeValidators(
  required,
  minLength(8),
  v => /[A-Z]/.test(v) ? null : 'Must contain uppercase',
  v => /[0-9]/.test(v) ? null : 'Must contain number'
);
```

### Middleware pattern

```typescript
type Middleware<T> = (value: T) => T;

const applyMiddleware = <T>(...middleware: Middleware<T>[]) =>
  (value: T): T =>
    middleware.reduce((acc, fn) => fn(acc), value);

// Request processing
const sanitizeInput: Middleware<Request> = req => ({
  ...req,
  body: req.body.trim()
});

const addTimestamp: Middleware<Request> = req => ({
  ...req,
  timestamp: Date.now()
});

const processRequest = applyMiddleware(
  sanitizeInput,
  addTimestamp,
  validateAuth
);
```

## Guidelines

- **Small functions:** Compose from single-purpose building blocks
- **Generic utilities:** Create reusable composition helpers (pipe, compose)
- **Type safety:** Ensure composed functions have compatible types
- **Readability:** Sometimes explicit is better than clever
- **Point-free judiciously:** Use when it improves clarity, not always
