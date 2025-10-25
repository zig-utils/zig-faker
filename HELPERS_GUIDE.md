# Helpers Module - Complete Guide

The Helpers module provides powerful utility functions for advanced data generation, selection, and manipulation.

## Quick Start

```zig
const std = @import("std");
const Faker = @import("zig-faker").Faker;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var faker = Faker.init(allocator, null, null);

    // Use helpers
    const random_bool = faker.helpers.boolean(&faker.random);
    std.debug.print("Random boolean: {}\n", .{random_bool});
}
```

## Array Utilities

### Array Element Selection

```zig
const items = [_][]const u8{ "apple", "banana", "cherry", "date", "elderberry" };

// Pick a single random element
const fruit = faker.helpers.arrayElement([]const u8, &faker.random, &items);

// Pick multiple elements (with replacement)
const fruits = try faker.helpers.arrayElements([]const u8, &faker.random, &items, 3);
defer allocator.free(fruits);

// Pick unique elements (without replacement)
const unique_fruits = try faker.helpers.arrayElementsUnique([]const u8, &faker.random, &items, 3);
defer allocator.free(unique_fruits);
```

### Array Shuffling

```zig
var my_array = [_]i32{ 1, 2, 3, 4, 5 };
faker.helpers.shuffle(i32, &faker.random, &my_array);
// my_array is now shuffled in place
```

### Subset Selection

```zig
const tags = [_][]const u8{ "tech", "sports", "music", "art", "food", "travel" };

// Get random subset (each element has 50% chance of being included)
const selected_tags = try faker.helpers.subset([]const u8, &faker.random, &tags, 0.5);
defer allocator.free(selected_tags);
```

## Boolean & Probability

### Simple Boolean

```zig
const coin_flip = faker.helpers.boolean(&faker.random);
// Returns true or false with 50% probability each
```

### Weighted Probability

```zig
// 70% chance of true
const likely = faker.helpers.maybe(&faker.random, 0.7);

// 10% chance of true
const unlikely = faker.helpers.maybe(&faker.random, 0.1);
```

### Nullable Values

```zig
const value = "important";

// 20% chance of returning null, 80% chance of returning the value
const maybe_value = faker.helpers.maybeNull([]const u8, &faker.random, value, 0.2);
```

## Weighted Selection

Perfect for realistic data generation with different probabilities:

```zig
const priorities = [_][]const u8{ "low", "medium", "high", "critical" };
const weights = [_]f64{ 0.4, 0.3, 0.2, 0.1 }; // 40%, 30%, 20%, 10%

const selected = try faker.helpers.weightedArrayElement(
    []const u8,
    &faker.random,
    &priorities,
    &weights
);
// More likely to get "low", less likely to get "critical"
```

### Real-World Example: Age Distribution

```zig
const age_groups = [_][]const u8{ "child", "teen", "adult", "senior" };
const age_weights = [_]f64{ 0.15, 0.15, 0.55, 0.15 }; // Realistic population distribution

const age_group = try faker.helpers.weightedArrayElement(
    []const u8,
    &faker.random,
    &age_groups,
    &age_weights
);
```

## Statistical Distributions

### Normal (Gaussian) Distribution

```zig
// Generate age with realistic distribution
// Mean age: 35, standard deviation: 12
const age = faker.helpers.normalDistribution(&faker.random, 35.0, 12.0);
const clamped_age = faker.helpers.clamp(f64, age, 18.0, 100.0);

// Generate height in cm
// Mean: 170cm, std dev: 10cm
const height = faker.helpers.normalDistribution(&faker.random, 170.0, 10.0);
```

## Pattern & Text Utilities

### Symbol Replacement

```zig
// # → random digit, ? → random letter
const pattern = try faker.helpers.replaceSymbols(&faker.random, "ID-####-????");
defer allocator.free(pattern);
// Example: "ID-7392-KXPQ"
```

### Unique ID Generation

```zig
const id = try faker.helpers.uniqueId(&faker.random);
defer allocator.free(id);
// Example: "a7b3f9e2-4d8c-1a5f-9e2b-7c4d8a1f5e9b"
```

### Slugify

```zig
const title = "Hello World! This is a Test";
const slug = try faker.helpers.slugify(title);
defer allocator.free(slug);
// Result: "hello-world-this-is-a-test"
```

### Hex Color Generation

```zig
const color = try faker.helpers.hexColor(&faker.random);
defer allocator.free(color);
// Example: "#a3f27e"
```

## Batch Generation

Generate multiple items at once:

```zig
// Define a generator function
fn generateEmail(random: *Random) []const u8 {
    // Your email generation logic
    return "user@example.com";
}

// Generate 100 emails
const emails = try faker.helpers.batchGenerate(
    []const u8,
    &faker.random,
    100,
    &generateEmail
);
defer allocator.free(emails);
```

## Sequence Generation

```zig
// Generate sequence from 1 to 10
const seq1 = try faker.helpers.sequence(1, 10, 1);
defer allocator.free(seq1);
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Generate even numbers
const evens = try faker.helpers.sequence(0, 20, 2);
defer allocator.free(evens);
// [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

// Countdown
const countdown = try faker.helpers.sequence(10, 0, -1);
defer allocator.free(countdown);
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
```

## String Utilities

### Repeat String

```zig
const repeated = try faker.helpers.repeatString("ha", 5);
defer allocator.free(repeated);
// "hahahahaha"
```

### Clamp Values

```zig
const value = 150;
const clamped = faker.helpers.clamp(i32, value, 0, 100);
// Result: 100 (clamped to max)
```

## Advanced Use Cases

### Realistic User Generation

```zig
const User = struct {
    name: []const u8,
    age: i32,
    priority: []const u8,
    tags: [][]const u8,
};

fn generateRealisticUser(faker: *Faker, allocator: std.mem.Allocator) !User {
    // Age with normal distribution (mean: 35, std dev: 12)
    const raw_age = faker.helpers.normalDistribution(&faker.random, 35.0, 12.0);
    const age = @as(i32, @intFromFloat(faker.helpers.clamp(f64, raw_age, 18.0, 80.0)));

    // Weighted priority
    const priorities = [_][]const u8{ "low", "medium", "high" };
    const weights = [_]f64{ 0.5, 0.35, 0.15 };
    const priority = try faker.helpers.weightedArrayElement(
        []const u8,
        &faker.random,
        &priorities,
        &weights
    );

    // Random subset of tags
    const all_tags = [_][]const u8{ "tech", "sports", "music", "art", "food" };
    const tags = try faker.helpers.subset([]const u8, &faker.random, &all_tags, 0.4);

    return User{
        .name = try faker.person.fullName(&faker.random, .{}),
        .age = age,
        .priority = priority,
        .tags = tags,
    };
}
```

### Weighted Name Generation

```zig
// More common first names get higher weights
const first_names = [_][]const u8{ "John", "Michael", "David", "Zebulon" };
const name_weights = [_]f64{ 0.4, 0.3, 0.25, 0.05 }; // Zebulon is rare

const name = try faker.helpers.weightedArrayElement(
    []const u8,
    &faker.random,
    &first_names,
    &name_weights
);
```

## Error Handling

```zig
// Most helper functions return errors for invalid inputs

// Empty array error
const result = faker.helpers.weightedArrayElement(
    []const u8,
    &faker.random,
    &[_][]const u8{},  // Empty!
    &[_]f64{}
) catch |err| {
    std.debug.print("Error: {}\n", .{err});
    // Error: error.EmptyArray
};

// Mismatched lengths error
const items = [_]i32{ 1, 2, 3 };
const weights = [_]f64{ 0.5, 0.5 }; // Wrong length!
const result2 = faker.helpers.weightedArrayElement(
    i32,
    &faker.random,
    &items,
    &weights
) catch |err| {
    // Error: error.MismatchedArrayLengths
};
```

## Performance Tips

1. **Reuse allocations**: When generating multiple items, consider batch generation
2. **Use weights wisely**: Weights don't need to sum to 1.0, they're relative
3. **Clamp distributions**: Always clamp normal distributions to realistic ranges
4. **Memory management**: Remember to free allocated memory with `defer`

## Summary

The Helpers module provides:
- ✅ 15+ utility functions
- ✅ Statistical distributions (normal/Gaussian)
- ✅ Weighted selection for realistic data
- ✅ Array manipulation and shuffling
- ✅ Batch generation capabilities
- ✅ Text utilities (slugify, patterns, etc.)
- ✅ Probability-based selection

Perfect for creating realistic, varied test data!
