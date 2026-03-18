# Zig Faker Cookbook

Common recipes and patterns for generating realistic test data.

## Table of Contents
1. [User Generation](#user-generation)
2. [E-commerce Data](#e-commerce-data)
3. [Blog & Content](#blog--content)
4. [Database Seeding](#database-seeding)
5. [API Testing](#api-testing)
6. [Realistic Demographics](#realistic-demographics)

---

## User Generation

### Basic User Profile

```zig
const User = struct {
    id: []const u8,
    first_name: []const u8,
    last_name: []const u8,
    email: []const u8,
    age: i32,
    city: []const u8,
};

fn generateUser(faker: *Faker, allocator: std.mem.Allocator) !User {
    const first_name = faker.person.firstName(&faker.random, .{});
    const last_name = faker.person.lastName(&faker.random);

    return User{
        .id = try faker.helpers.uniqueId(&faker.random),
        .first_name = first_name,
        .last_name = last_name,
        .email = try faker.internet.email(&faker.random, .{
            .first_name = first_name,
            .last_name = last_name
        }),
        .age = faker.random.int(18, 80),
        .city = faker.address.city(&faker.random),
    };
}
```

### User with Realistic Age Distribution

```zig
fn generateRealisticUser(faker: *Faker, allocator: std.mem.Allocator) !User {
    // Age follows normal distribution (mean: 35, std dev: 12)
    const raw_age = faker.helpers.normalDistribution(&faker.random, 35.0, 12.0);
    const age = @as(i32, @intFromFloat(faker.helpers.clamp(f64, raw_age, 18.0, 80.0)));

    const first_name = faker.person.firstName(&faker.random, .{});
    const last_name = faker.person.lastName(&faker.random);

    return User{
        .id = try faker.helpers.uniqueId(&faker.random),
        .first_name = first_name,
        .last_name = last_name,
        .email = try faker.internet.email(&faker.random, .{
            .first_name = first_name,
            .last_name = last_name
        }),
        .age = age,
        .city = faker.address.city(&faker.random),
    };
}
```

### User with Role-based Permissions

```zig
const UserRole = enum { admin, moderator, user, guest };

fn generateUserWithRole(faker: *Faker) !struct {
    user: User,
    role: UserRole
} {
    const roles = [_]UserRole{ .admin, .moderator, .user, .guest };
    const weights = [_]f64{ 0.05, 0.10, 0.70, 0.15 }; // 5% admin, 70% regular users

    const role_idx = try faker.helpers.weightedArrayElement(
        usize,
        &faker.random,
        &[_]usize{0, 1, 2, 3},
        &weights
    );

    return .{
        .user = try generateUser(faker, faker.allocator),
        .role = roles[role_idx],
    };
}
```

---

## E-commerce Data

### Product Generation

```zig
const Product = struct {
    id: []const u8,
    name: []const u8,
    description: []const u8,
    price: f64,
    category: []const u8,
    in_stock: bool,
    tags: [][]const u8,
};

fn generateProduct(faker: *Faker) !Product {
    const product_name = try faker.commerce.productName(&faker.random);
    const price = faker.commerce.price(&faker.random, 10.0, 1000.0);

    // 80% chance of being in stock
    const in_stock = faker.helpers.maybe(&faker.random, 0.8);

    // Random subset of tags
    const all_tags = [_][]const u8{ "new", "sale", "popular", "limited", "bestseller" };
    const tags = try faker.helpers.subset([]const u8, &faker.random, &all_tags, 0.4);

    return Product{
        .id = try faker.helpers.uniqueId(&faker.random),
        .name = product_name,
        .description = try faker.lorem.sentence(&faker.random, 10),
        .price = price,
        .category = faker.commerce.department(&faker.random),
        .in_stock = in_stock,
        .tags = tags,
    };
}
```

### Order Generation

```zig
const Order = struct {
    id: []const u8,
    user_id: []const u8,
    items: []OrderItem,
    total: f64,
    status: []const u8,
    created_at: i64,
};

const OrderItem = struct {
    product_id: []const u8,
    quantity: i32,
    price: f64,
};

fn generateOrder(faker: *Faker, user_id: []const u8) !Order {
    const statuses = [_][]const u8{ "pending", "processing", "shipped", "delivered" };
    const weights = [_]f64{ 0.10, 0.20, 0.30, 0.40 }; // Most orders are delivered

    const status = try faker.helpers.weightedArrayElement(
        []const u8,
        &faker.random,
        &statuses,
        &weights
    );

    // Generate 1-5 items per order
    const item_count = faker.random.int(1, 5);
    var items = try faker.allocator.alloc(OrderItem, @intCast(item_count));
    var total: f64 = 0.0;

    for (0..item_count) |i| {
        const price = faker.commerce.price(&faker.random, 10.0, 200.0);
        const quantity = faker.random.int(1, 3);
        items[i] = OrderItem{
            .product_id = try faker.helpers.uniqueId(&faker.random),
            .quantity = @intCast(quantity),
            .price = price,
        };
        total += price * @as(f64, @floatFromInt(quantity));
    }

    return Order{
        .id = try faker.helpers.uniqueId(&faker.random),
        .user_id = user_id,
        .items = items,
        .total = total,
        .status = status,
        .created_at = faker.date.unix(&faker.random),
    };
}
```

---

## Blog & Content

### Blog Post Generation

```zig
const BlogPost = struct {
    id: []const u8,
    title: []const u8,
    slug: []const u8,
    author: []const u8,
    content: []const u8,
    tags: [][]const u8,
    views: i32,
    published_at: i64,
};

fn generateBlogPost(faker: *Faker) !BlogPost {
    // Generate title from words
    const adj = faker.word.adjective(&faker.random);
    const noun1 = faker.word.noun(&faker.random);
    const noun2 = faker.word.noun(&faker.random);

    const title = try std.fmt.allocPrint(
        faker.allocator,
        "The {s} {s} and {s}",
        .{adj, noun1, noun2}
    );

    const slug = try faker.helpers.slugify(title);
    const content = try faker.lorem.paragraphs(&faker.random, faker.allocator, 3);

    // Views follow realistic distribution (most posts have few views)
    const raw_views = faker.helpers.normalDistribution(&faker.random, 500.0, 300.0);
    const views = @as(i32, @intFromFloat(faker.helpers.clamp(f64, raw_views, 0.0, 10000.0)));

    const all_tags = [_][]const u8{ "tech", "lifestyle", "news", "tutorial", "review" };
    const tags = try faker.helpers.subset([]const u8, &faker.random, &all_tags, 0.5);

    return BlogPost{
        .id = try faker.helpers.uniqueId(&faker.random),
        .title = title,
        .slug = slug,
        .author = try faker.person.fullName(&faker.random, .{}),
        .content = content,
        .tags = tags,
        .views = views,
        .published_at = faker.date.unix(&faker.random),
    };
}
```

### Comment Thread

```zig
const Comment = struct {
    id: []const u8,
    post_id: []const u8,
    author: []const u8,
    content: []const u8,
    upvotes: i32,
    created_at: i64,
};

fn generateCommentThread(faker: *Faker, post_id: []const u8, count: usize) ![]Comment {
    var comments = try faker.allocator.alloc(Comment, count);

    for (0..count) |i| {
        // Upvotes follow power law (most comments have few upvotes)
        const raw_upvotes = faker.helpers.normalDistribution(&faker.random, 5.0, 10.0);
        const upvotes = @as(i32, @intFromFloat(faker.helpers.clamp(f64, raw_upvotes, 0.0, 100.0)));

        comments[i] = Comment{
            .id = try faker.helpers.uniqueId(&faker.random),
            .post_id = post_id,
            .author = try faker.person.fullName(&faker.random, .{}),
            .content = try faker.lorem.sentence(&faker.random, faker.random.int(5, 20)),
            .upvotes = upvotes,
            .created_at = faker.date.unix(&faker.random),
        };
    }

    return comments;
}
```

---

## Database Seeding

### Generate Multiple Records

```zig
fn seedUsers(faker: *Faker, count: usize) ![]User {
    var users = try faker.allocator.alloc(User, count);

    for (0..count) |i| {
        users[i] = try generateRealisticUser(faker, faker.allocator);
    }

    return users;
}

// Usage
const users = try seedUsers(&faker, 100);
```

### Related Data Generation

```zig
fn seedRelatedData(faker: *Faker) !void {
    // Generate users
    const users = try seedUsers(faker, 50);
    defer faker.allocator.free(users);

    // Generate orders for each user
    for (users) |user| {
        const order_count = faker.random.int(0, 5);
        for (0..order_count) |_| {
            const order = try generateOrder(faker, user.id);
            // Save order to database
            defer faker.allocator.free(order.items);
        }
    }
}
```

---

## API Testing

### Mock API Response

```zig
const ApiResponse = struct {
    status: i32,
    data: []User,
    pagination: struct {
        page: i32,
        per_page: i32,
        total: i32,
    },
};

fn generateApiResponse(faker: *Faker, page: i32, per_page: i32) !ApiResponse {
    const users = try seedUsers(faker, @intCast(per_page));

    return ApiResponse{
        .status = 200,
        .data = users,
        .pagination = .{
            .page = page,
            .per_page = per_page,
            .total = faker.random.int(100, 1000),
        },
    };
}
```

### Error Response Simulation

```zig
fn generateErrorResponse(faker: *Faker) !struct {
    status: i32,
    error: []const u8,
    message: []const u8,
} {
    const error_codes = [_]i32{ 400, 401, 403, 404, 500 };
    const weights = [_]f64{ 0.3, 0.2, 0.1, 0.3, 0.1 };

    const status = try faker.helpers.weightedArrayElement(
        i32,
        &faker.random,
        &error_codes,
        &weights
    );

    const error_messages = std.ComptimeStringMap([]const u8, .{
        .{ "400", "Bad Request" },
        .{ "401", "Unauthorized" },
        .{ "403", "Forbidden" },
        .{ "404", "Not Found" },
        .{ "500", "Internal Server Error" },
    });

    const status_str = try std.fmt.allocPrint(faker.allocator, "{d}", .{status});
    defer faker.allocator.free(status_str);

    return .{
        .status = status,
        .error = error_messages.get(status_str) orelse "Unknown Error",
        .message = try faker.lorem.sentence(&faker.random, 8),
    };
}
```

---

## Realistic Demographics

### Age Groups

```zig
fn generateByAgeGroup(faker: *Faker) !struct {
    person: []const u8,
    age: i32
} {
    const age_groups = [_]struct { min: f64, max: f64, mean: f64, std: f64 }{
        .{ .min = 18, .max = 25, .mean = 21, .std = 2 },  // Young adults
        .{ .min = 26, .max = 40, .mean = 33, .std = 4 },  // Adults
        .{ .min = 41, .max = 60, .mean = 50, .std = 5 },  // Middle age
        .{ .min = 61, .max = 80, .mean = 70, .std = 5 },  // Seniors
    };

    const group_weights = [_]f64{ 0.20, 0.45, 0.25, 0.10 };
    const group_idx = try faker.helpers.weightedArrayElement(
        usize,
        &faker.random,
        &[_]usize{0, 1, 2, 3},
        &group_weights
    );

    const group = age_groups[group_idx];
    const raw_age = faker.helpers.normalDistribution(&faker.random, group.mean, group.std);
    const age = @as(i32, @intFromFloat(faker.helpers.clamp(f64, raw_age, group.min, group.max)));

    return .{
        .person = try faker.person.fullName(&faker.random, .{}),
        .age = age,
    };
}
```

### Geographic Distribution

```zig
fn generateByRegion(faker: *Faker) !struct {
    name: []const u8,
    city: []const u8,
    state: []const u8,
} {
    // Weight by population
    const states = [_][]const u8{ "California", "Texas", "Florida", "New York", "Pennsylvania" };
    const pop_weights = [_]f64{ 0.25, 0.20, 0.18, 0.15, 0.12 };

    const state = try faker.helpers.weightedArrayElement(
        []const u8,
        &faker.random,
        &states,
        &pop_weights
    );

    return .{
        .name = try faker.person.fullName(&faker.random, .{}),
        .city = faker.address.city(&faker.random),
        .state = state,
    };
}
```

---

## Best Practices

### Memory Management

```zig
// Always free allocated memory
const user = try generateUser(&faker, allocator);
defer {
    allocator.free(user.id);
    allocator.free(user.email);
}
```

### Seeded Generation for Tests

```zig
test "reproducible data generation" {
    const allocator = std.testing.allocator;

    // Same seed = same data
    var faker1 = Faker.init(allocator, 12345, null);
    var faker2 = Faker.init(allocator, 12345, null);

    const name1 = faker1.person.firstName(&faker1.random, .{});
    const name2 = faker2.person.firstName(&faker2.random, .{});

    try std.testing.expectEqualStrings(name1, name2);
}
```

### Batch Generation

```zig
// Use helpers for efficient batch generation
const emails = try faker.helpers.batchGenerate(
    []const u8,
    &faker.random,
    1000,
    &generateEmail
);
defer allocator.free(emails);
```

---

## Performance Tips

1. **Reuse Faker instance**: Create once, use many times
2. **Use seeds for tests**: Reproducible and faster
3. **Batch generate**: More efficient than loops
4. **Pre-allocate**: When you know the count
5. **Profile your code**: Use `zig build-exe -O ReleaseFast`
