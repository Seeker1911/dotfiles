// Data Transformation Examples - Functional vs Imperative

type User = {
  id: string;
  name: string;
  age: number;
  email: string;
  verified: boolean;
  subscriptionTier: 'free' | 'basic' | 'premium';
  orders: Order[];
};

type Order = {
  id: string;
  total: number;
  status: 'pending' | 'completed' | 'cancelled';
  items: OrderItem[];
};

type OrderItem = {
  productId: string;
  quantity: number;
  price: number;
};

// ❌ IMPERATIVE APPROACH
function getUserRevenueImperative(users: User[]): Record<string, number> {
  let result: Record<string, number> = {};

  for (let i = 0; i < users.length; i++) {
    let user = users[i];
    let totalRevenue = 0;

    if (user.verified && user.subscriptionTier !== 'free') {
      for (let j = 0; j < user.orders.length; j++) {
        let order = user.orders[j];
        if (order.status === 'completed') {
          totalRevenue += order.total;
        }
      }
      result[user.id] = totalRevenue;
    }
  }

  return result;
}

// ✅ FUNCTIONAL APPROACH
const isPayingUser = (user: User): boolean =>
  user.verified && user.subscriptionTier !== 'free';

const isCompletedOrder = (order: Order): boolean =>
  order.status === 'completed';

const sumOrderTotals = (orders: Order[]): number =>
  orders
    .filter(isCompletedOrder)
    .reduce((sum, order) => sum + order.total, 0);

const getUserRevenue = (users: User[]): Record<string, number> =>
  Object.fromEntries(
    users
      .filter(isPayingUser)
      .map(user => [user.id, sumOrderTotals(user.orders)])
  );

// ✅ PIPELINE EXAMPLE
const pipe = <T>(...fns: Array<(arg: any) => any>) =>
  (value: T) => fns.reduce((acc, fn) => fn(acc), value);

const getTopCustomers = (users: User[], limit: number) => pipe(
  (users: User[]) => users.filter(isPayingUser),
  (users: User[]) => users.map(user => ({
    user,
    revenue: sumOrderTotals(user.orders)
  })),
  (results: Array<{ user: User; revenue: number }>) =>
    results.toSorted((a, b) => b.revenue - a.revenue),
  (sorted: Array<{ user: User; revenue: number }>) => sorted.slice(0, limit)
)(users);

// ✅ COMPOSITION EXAMPLE
const addRevenue = (user: User) => ({
  ...user,
  totalRevenue: sumOrderTotals(user.orders)
});

const addMetrics = (user: User & { totalRevenue: number }) => ({
  ...user,
  orderCount: user.orders.filter(isCompletedOrder).length,
  avgOrderValue: user.totalRevenue / user.orders.filter(isCompletedOrder).length || 0
});

const enrichUser = pipe(addRevenue, addMetrics);

const enrichedUsers = users.filter(isPayingUser).map(enrichUser);

// ✅ ADVANCED: GROUPING AND AGGREGATION
const groupBy = <T, K extends string | number>(
  arr: T[],
  key: (item: T) => K
): Record<K, T[]> =>
  arr.reduce((acc, item) => {
    const k = key(item);
    return { ...acc, [k]: [...(acc[k] ?? []), item] };
  }, {} as Record<K, T[]>);

const revenueByTier = (users: User[]) => {
  const byTier = groupBy(users, user => user.subscriptionTier);

  return Object.fromEntries(
    Object.entries(byTier).map(([tier, tierUsers]) => [
      tier,
      tierUsers.reduce((sum, user) => sum + sumOrderTotals(user.orders), 0)
    ])
  );
};

// ✅ CONDITIONAL TRANSFORMATIONS
const applyDiscount = (tier: User['subscriptionTier']) => (total: number): number => {
  switch (tier) {
    case 'premium': return total * 0.8;
    case 'basic': return total * 0.95;
    case 'free': return total;
  }
};

const calculateFinalPrice = (user: User, order: Order): number =>
  applyDiscount(user.subscriptionTier)(order.total);

// ✅ IMMUTABLE UPDATES
const upgradeUser = (user: User): User => ({
  ...user,
  subscriptionTier: user.subscriptionTier === 'free' ? 'basic' :
                    user.subscriptionTier === 'basic' ? 'premium' :
                    user.subscriptionTier
});

const addOrderToUser = (user: User, order: Order): User => ({
  ...user,
  orders: [...user.orders, order]
});

const updateOrderStatus = (
  user: User,
  orderId: string,
  status: Order['status']
): User => ({
  ...user,
  orders: user.orders.map(order =>
    order.id === orderId ? { ...order, status } : order
  )
});

// Example usage
const users: User[] = [
  {
    id: '1',
    name: 'Alice',
    age: 30,
    email: 'alice@example.com',
    verified: true,
    subscriptionTier: 'premium',
    orders: [
      { id: 'o1', total: 100, status: 'completed', items: [] },
      { id: 'o2', total: 200, status: 'completed', items: [] }
    ]
  }
];

const revenue = getUserRevenue(users);
const topCustomers = getTopCustomers(users, 10);
const tierRevenue = revenueByTier(users);
