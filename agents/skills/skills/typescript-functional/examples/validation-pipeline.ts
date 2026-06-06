// Validation Pipeline - Functional Composition

type ValidationResult<T> =
  | { success: true; value: T }
  | { success: false; errors: string[] };

type Validator<T> = (value: T) => string | null;

// ✅ COMPOSABLE VALIDATORS

// String validators
const required: Validator<string> = value =>
  value.trim().length > 0 ? null : 'Required field';

const minLength = (min: number): Validator<string> => value =>
  value.length >= min ? null : `Minimum ${min} characters`;

const maxLength = (max: number): Validator<string> => value =>
  value.length <= max ? null : `Maximum ${max} characters`;

const pattern = (regex: RegExp, message: string): Validator<string> => value =>
  regex.test(value) ? null : message;

const email = pattern(
  /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
  'Invalid email format'
);

const phone = pattern(
  /^\+?[1-9]\d{1,14}$/,
  'Invalid phone number'
);

// Number validators
const min = (minimum: number): Validator<number> => value =>
  value >= minimum ? null : `Must be at least ${minimum}`;

const max = (maximum: number): Validator<number> => value =>
  value <= maximum ? null : `Must be at most ${maximum}`;

const inRange = (minimum: number, maximum: number): Validator<number> => value =>
  value >= minimum && value <= maximum
    ? null
    : `Must be between ${minimum} and ${maximum}`;

// ✅ VALIDATOR COMPOSITION

const composeValidators = <T>(...validators: Validator<T>[]) =>
  (value: T): string[] =>
    validators
      .map(validator => validator(value))
      .filter((error): error is string => error !== null);

const validate = <T>(value: T, ...validators: Validator<T>[]): ValidationResult<T> => {
  const errors = composeValidators(...validators)(value);
  return errors.length === 0
    ? { success: true, value }
    : { success: false, errors };
};

// ✅ FIELD VALIDATORS

const passwordValidation = composeValidators(
  required,
  minLength(8),
  pattern(/[A-Z]/, 'Must contain uppercase letter'),
  pattern(/[a-z]/, 'Must contain lowercase letter'),
  pattern(/[0-9]/, 'Must contain number'),
  pattern(/[^A-Za-z0-9]/, 'Must contain special character')
);

const usernameValidation = composeValidators(
  required,
  minLength(3),
  maxLength(20),
  pattern(/^[a-zA-Z0-9_]+$/, 'Only letters, numbers, and underscores')
);

const ageValidation = composeValidators(
  inRange(13, 120)
);

// ✅ OBJECT VALIDATION

type UserInput = {
  username: string;
  email: string;
  password: string;
  age: number;
};

type FieldValidators<T> = {
  [K in keyof T]: Validator<T[K]>[];
};

const validateObject = <T extends Record<string, any>>(
  obj: T,
  validators: FieldValidators<T>
): ValidationResult<T> => {
  const errors = Object.entries(validators).flatMap(([key, fieldValidators]) =>
    composeValidators(...(fieldValidators as Validator<any>[]))(obj[key])
      .map(error => `${key}: ${error}`)
  );

  return errors.length === 0
    ? { success: true, value: obj }
    : { success: false, errors };
};

const userValidators: FieldValidators<UserInput> = {
  username: [required, minLength(3), maxLength(20)],
  email: [required, email],
  password: [
    required,
    minLength(8),
    pattern(/[A-Z]/, 'Must contain uppercase'),
    pattern(/[0-9]/, 'Must contain number')
  ],
  age: [min(13), max(120)]
};

// ✅ CONDITIONAL VALIDATION

const when = <T>(
  condition: (value: T) => boolean,
  validator: Validator<T>
): Validator<T> => value =>
  condition(value) ? validator(value) : null;

// Only validate if value is present
const optional = <T>(validator: Validator<T>): Validator<T | undefined | null> =>
  value => value == null ? null : validator(value as T);

// Example: require company name only for business accounts
type SignupForm = {
  email: string;
  accountType: 'personal' | 'business';
  companyName?: string;
};

const signupValidation = (form: SignupForm): ValidationResult<SignupForm> => {
  const errors: string[] = [];

  const emailErrors = composeValidators(required, email)(form.email);
  errors.push(...emailErrors.map(e => `email: ${e}`));

  if (form.accountType === 'business') {
    const companyErrors = composeValidators(required, minLength(2))(form.companyName ?? '');
    errors.push(...companyErrors.map(e => `companyName: ${e}`));
  }

  return errors.length === 0
    ? { success: true, value: form }
    : { success: false, errors };
};

// ✅ ASYNC VALIDATION

type AsyncValidator<T> = (value: T) => Promise<string | null>;

const composeAsyncValidators = <T>(...validators: AsyncValidator<T>[]) =>
  async (value: T): Promise<string[]> => {
    const results = await Promise.all(validators.map(v => v(value)));
    return results.filter((error): error is string => error !== null);
  };

const validateAsync = async <T>(
  value: T,
  ...validators: AsyncValidator<T>[]
): Promise<ValidationResult<T>> => {
  const errors = await composeAsyncValidators(...validators)(value);
  return errors.length === 0
    ? { success: true, value }
    : { success: false, errors };
};

// Example: check if username is available
const usernameAvailable: AsyncValidator<string> = async username => {
  // Simulate API call
  const taken = ['admin', 'root', 'user'];
  await new Promise(resolve => setTimeout(resolve, 100));
  return taken.includes(username.toLowerCase())
    ? 'Username already taken'
    : null;
};

const emailAvailable: AsyncValidator<string> = async email => {
  // Simulate API call
  await new Promise(resolve => setTimeout(resolve, 100));
  return email === 'taken@example.com'
    ? 'Email already registered'
    : null;
};

// ✅ SANITIZATION PIPELINE

const sanitize = <T>(value: T, ...transforms: Array<(v: T) => T>): T =>
  transforms.reduce((acc, fn) => fn(acc), value);

const trim = (s: string): string => s.trim();
const toLowerCase = (s: string): string => s.toLowerCase();
const removeSpaces = (s: string): string => s.replace(/\s+/g, '');
const normalizeEmail = (s: string): string => sanitize(s, trim, toLowerCase);

// ✅ VALIDATION + SANITIZATION

type ProcessResult<T> = ValidationResult<T>;

const processInput = <T>(
  value: T,
  sanitizers: Array<(v: T) => T>,
  validators: Validator<T>[]
): ProcessResult<T> => {
  const sanitized = sanitize(value, ...sanitizers);
  return validate(sanitized, ...validators);
};

// Example usage
const result = validateObject(
  {
    username: 'john_doe',
    email: 'john@example.com',
    password: 'SecurePass123!',
    age: 25
  },
  userValidators
);

if (result.success) {
  console.log('Valid user:', result.value);
} else {
  console.log('Validation errors:', result.errors);
}

// Async example
const validateSignup = async (username: string, email: string) => {
  const usernameResult = await validateAsync(
    username,
    async u => required(u),
    async u => minLength(3)(u),
    usernameAvailable
  );

  const emailResult = await validateAsync(
    email,
    async e => required(e),
    async e => pattern(/^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Invalid email')(e),
    emailAvailable
  );

  return { usernameResult, emailResult };
};
