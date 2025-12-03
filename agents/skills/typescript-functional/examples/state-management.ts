// State Management - Functional Patterns

// ✅ IMMUTABLE STATE UPDATES

type Todo = {
  id: string;
  text: string;
  completed: boolean;
  createdAt: number;
};

type AppState = {
  todos: Todo[];
  filter: 'all' | 'active' | 'completed';
  user: { name: string; id: string } | null;
};

// Pure state update functions
const addTodo = (state: AppState, text: string): AppState => ({
  ...state,
  todos: [
    ...state.todos,
    {
      id: crypto.randomUUID(),
      text,
      completed: false,
      createdAt: Date.now()
    }
  ]
});

const toggleTodo = (state: AppState, id: string): AppState => ({
  ...state,
  todos: state.todos.map(todo =>
    todo.id === id ? { ...todo, completed: !todo.completed } : todo
  )
});

const deleteTodo = (state: AppState, id: string): AppState => ({
  ...state,
  todos: state.todos.filter(todo => todo.id !== id)
});

const setFilter = (
  state: AppState,
  filter: AppState['filter']
): AppState => ({
  ...state,
  filter
});

const clearCompleted = (state: AppState): AppState => ({
  ...state,
  todos: state.todos.filter(todo => !todo.completed)
});

// ✅ DERIVED STATE (SELECTORS)

const selectFilteredTodos = (state: AppState): Todo[] => {
  switch (state.filter) {
    case 'active': return state.todos.filter(t => !t.completed);
    case 'completed': return state.todos.filter(t => t.completed);
    case 'all': return state.todos;
  }
};

const selectActiveTodoCount = (state: AppState): number =>
  state.todos.filter(t => !t.completed).length;

const selectCompletedTodoCount = (state: AppState): number =>
  state.todos.filter(t => t.completed).length;

const selectIsAllCompleted = (state: AppState): boolean =>
  state.todos.length > 0 && state.todos.every(t => t.completed);

// ✅ REDUCER PATTERN

type Action =
  | { type: 'ADD_TODO'; text: string }
  | { type: 'TOGGLE_TODO'; id: string }
  | { type: 'DELETE_TODO'; id: string }
  | { type: 'SET_FILTER'; filter: AppState['filter'] }
  | { type: 'CLEAR_COMPLETED' }
  | { type: 'TOGGLE_ALL' };

const reducer = (state: AppState, action: Action): AppState => {
  switch (action.type) {
    case 'ADD_TODO':
      return addTodo(state, action.text);

    case 'TOGGLE_TODO':
      return toggleTodo(state, action.id);

    case 'DELETE_TODO':
      return deleteTodo(state, action.id);

    case 'SET_FILTER':
      return setFilter(state, action.filter);

    case 'CLEAR_COMPLETED':
      return clearCompleted(state);

    case 'TOGGLE_ALL': {
      const allCompleted = selectIsAllCompleted(state);
      return {
        ...state,
        todos: state.todos.map(todo => ({
          ...todo,
          completed: !allCompleted
        }))
      };
    }

    default:
      return state;
  }
};

// ✅ ACTION CREATORS

const createAddTodoAction = (text: string): Action => ({
  type: 'ADD_TODO',
  text
});

const createToggleTodoAction = (id: string): Action => ({
  type: 'TOGGLE_TODO',
  id
});

const createDeleteTodoAction = (id: string): Action => ({
  type: 'DELETE_TODO',
  id
});

// ✅ MIDDLEWARE PATTERN

type Middleware<S, A> = (
  state: S,
  action: A,
  next: (state: S, action: A) => S
) => S;

const logger: Middleware<AppState, Action> = (state, action, next) => {
  console.log('Action:', action.type);
  console.log('Previous state:', state);
  const nextState = next(state, action);
  console.log('Next state:', nextState);
  return nextState;
};

const crashReporter: Middleware<AppState, Action> = (state, action, next) => {
  try {
    return next(state, action);
  } catch (error) {
    console.error('State update failed:', error);
    console.error('Action:', action);
    console.error('State:', state);
    return state; // Return unchanged state on error
  }
};

const composeMiddleware = <S, A>(
  ...middleware: Middleware<S, A>[]
) => (reducer: (state: S, action: A) => S) =>
  (state: S, action: A): S =>
    middleware.reduceRight(
      (next, mw) => (s: S, a: A) => mw(s, a, next),
      reducer
    )(state, action);

// Enhanced reducer with middleware
const enhancedReducer = composeMiddleware(logger, crashReporter)(reducer);

// ✅ STATE HISTORY (UNDO/REDO)

type History<T> = {
  past: T[];
  present: T;
  future: T[];
};

const createHistory = <T>(initialState: T): History<T> => ({
  past: [],
  present: initialState,
  future: []
});

const historyReducer = <T>(
  history: History<T>,
  action: Action | { type: 'UNDO' } | { type: 'REDO' },
  baseReducer: (state: T, action: Action) => T
): History<T> => {
  switch (action.type) {
    case 'UNDO': {
      const [previous, ...rest] = history.past;
      return previous
        ? {
            past: rest,
            present: previous,
            future: [history.present, ...history.future]
          }
        : history;
    }

    case 'REDO': {
      const [next, ...rest] = history.future;
      return next
        ? {
            past: [history.present, ...history.past],
            present: next,
            future: rest
          }
        : history;
    }

    default: {
      const newPresent = baseReducer(history.present, action as Action);
      return newPresent === history.present
        ? history
        : {
            past: [history.present, ...history.past],
            present: newPresent,
            future: [] // Clear future on new action
          };
    }
  }
};

// ✅ COMPUTED VALUES (MEMOIZATION)

const createMemoized = <Args extends any[], Result>(
  fn: (...args: Args) => Result
) => {
  let lastArgs: Args | undefined;
  let lastResult: Result | undefined;

  return (...args: Args): Result => {
    if (
      lastArgs === undefined ||
      args.some((arg, i) => arg !== lastArgs![i])
    ) {
      lastArgs = args;
      lastResult = fn(...args);
    }
    return lastResult!;
  };
};

// Memoized selectors for performance
const selectFilteredTodosMemo = createMemoized(selectFilteredTodos);
const selectActiveTodoCountMemo = createMemoized(selectActiveTodoCount);

// ✅ EFFECT MANAGEMENT

type Effect = () => void | (() => void);

type StateUpdate<S> = {
  state: S;
  effects: Effect[];
};

// Separate state updates from effects
const addTodoWithEffect = (
  state: AppState,
  text: string
): StateUpdate<AppState> => ({
  state: addTodo(state, text),
  effects: [
    () => console.log('Todo added:', text),
    () => localStorage.setItem('todos', JSON.stringify(state.todos))
  ]
});

// ✅ ASYNC STATE UPDATES

type AsyncState<T> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: string };

const createAsyncState = <T>(): AsyncState<T> => ({ status: 'idle' });

const setLoading = <T>(state: AsyncState<T>): AsyncState<T> => ({
  status: 'loading'
});

const setSuccess = <T>(data: T): AsyncState<T> => ({
  status: 'success',
  data
});

const setError = <T>(error: string): AsyncState<T> => ({
  status: 'error',
  error
});

// Pattern matching for async state
const matchAsyncState = <T, R>(
  state: AsyncState<T>,
  patterns: {
    idle: () => R;
    loading: () => R;
    success: (data: T) => R;
    error: (error: string) => R;
  }
): R => {
  switch (state.status) {
    case 'idle': return patterns.idle();
    case 'loading': return patterns.loading();
    case 'success': return patterns.success(state.data);
    case 'error': return patterns.error(state.error);
  }
};

// Usage
type UserData = { id: string; name: string };
const userState: AsyncState<UserData> = { status: 'idle' };

const renderUser = (state: AsyncState<UserData>) =>
  matchAsyncState(state, {
    idle: () => 'Not loaded',
    loading: () => 'Loading...',
    success: data => `Welcome, ${data.name}`,
    error: error => `Error: ${error}`
  });

// ✅ COMMAND PATTERN

type Command<S> = {
  execute: (state: S) => S;
  undo: (state: S) => S;
};

const createCommand = <S>(
  execute: (state: S) => S,
  undo: (state: S) => S
): Command<S> => ({ execute, undo });

const addTodoCommand = (text: string): Command<AppState> =>
  createCommand(
    state => addTodo(state, text),
    state => ({
      ...state,
      todos: state.todos.slice(0, -1) // Remove last todo
    })
  );

const executeCommands = <S>(
  state: S,
  commands: Command<S>[]
): S =>
  commands.reduce((s, cmd) => cmd.execute(s), state);

// Example usage
const initialState: AppState = {
  todos: [],
  filter: 'all',
  user: null
};

let state = initialState;
state = reducer(state, { type: 'ADD_TODO', text: 'Learn functional programming' });
state = reducer(state, { type: 'ADD_TODO', text: 'Practice TypeScript' });
state = reducer(state, { type: 'TOGGLE_TODO', id: state.todos[0].id });

const filtered = selectFilteredTodos(state);
const activeCount = selectActiveTodoCount(state);
