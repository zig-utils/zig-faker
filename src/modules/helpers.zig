const std = @import("std");
const Random = @import("../random.zig").Random;

/// Helpers module providing utility functions for data generation
pub const Helpers = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Helpers {
        return Helpers{
            .allocator = allocator,
        };
    }

    /// Pick a single random element from an array
    /// This is a convenience wrapper around Random.arrayElement
    pub fn arrayElement(self: *Helpers, comptime T: type, random: *Random, items: []const T) T {
        _ = self;
        return random.arrayElement(T, items);
    }

    /// Pick multiple random elements from an array (with replacement)
    pub fn arrayElements(self: *Helpers, comptime T: type, random: *Random, items: []const T, count: usize) ![]T {
        var result = try self.allocator.alloc(T, count);
        for (0..count) |i| {
            result[i] = random.arrayElement(T, items);
        }
        return result;
    }

    /// Pick multiple unique random elements from an array (without replacement)
    pub fn arrayElementsUnique(self: *Helpers, comptime T: type, random: *Random, items: []const T, count: usize) ![]T {
        if (count > items.len) {
            return error.CountExceedsArraySize;
        }

        // Create a copy of the items array
        var available = try self.allocator.alloc(T, items.len);
        defer self.allocator.free(available);
        @memcpy(available, items);

        var result = try self.allocator.alloc(T, count);

        // Fisher-Yates shuffle for first count elements
        var i: usize = 0;
        while (i < count) : (i += 1) {
            const j = random.int(@intCast(i), @intCast(available.len - 1));
            const temp = available[i];
            available[i] = available[@intCast(j)];
            available[@intCast(j)] = temp;
            result[i] = available[i];
        }

        return result;
    }

    /// Shuffle an array in place using Fisher-Yates algorithm
    pub fn shuffle(self: *Helpers, comptime T: type, random: *Random, items: []T) void {
        _ = self;
        if (items.len <= 1) return;

        var i: usize = items.len - 1;
        while (i > 0) : (i -= 1) {
            const j = random.int(0, @intCast(i));
            const temp = items[i];
            items[i] = items[@intCast(j)];
            items[@intCast(j)] = temp;
        }
    }

    /// Generate a random boolean value
    pub fn boolean(self: *Helpers, random: *Random) bool {
        _ = self;
        return random.int(0, 1) == 1;
    }

    /// Generate a random boolean with a specific probability of being true
    /// probability should be between 0.0 and 1.0
    pub fn maybe(self: *Helpers, random: *Random, probability: f64) bool {
        _ = self;
        const value = random.float(0.0, 1.0);
        return value < probability;
    }

    /// Return null with a given probability, otherwise return the value
    pub fn maybeNull(self: *Helpers, comptime T: type, random: *Random, value: T, null_probability: f64) ?T {
        if (self.maybe(random, null_probability)) {
            return null;
        }
        return value;
    }

    /// Replace # with random digit and ? with random letter in a pattern string
    /// This is a convenience wrapper around Random.replaceSymbols
    pub fn replaceSymbols(self: *Helpers, random: *Random, pattern: []const u8) ![]u8 {
        return random.replaceSymbols(self.allocator, pattern);
    }

    /// Generate a unique identifier string
    pub fn uniqueId(self: *Helpers, random: *Random) ![]u8 {
        return random.replaceSymbols(self.allocator, "????????-????-????-????-????????????");
    }

    /// Pick a weighted random element from an array
    /// weights must be same length as items
    /// weights are relative (don't need to sum to 1.0)
    pub fn weightedArrayElement(self: *Helpers, comptime T: type, random: *Random, items: []const T, weights: []const f64) !T {
        _ = self;
        if (items.len != weights.len) {
            return error.MismatchedArrayLengths;
        }
        if (items.len == 0) {
            return error.EmptyArray;
        }

        // Calculate total weight
        var total_weight: f64 = 0.0;
        for (weights) |weight| {
            if (weight < 0.0) {
                return error.NegativeWeight;
            }
            total_weight += weight;
        }

        if (total_weight <= 0.0) {
            return error.ZeroTotalWeight;
        }

        // Pick a random value between 0 and total_weight
        const rand_value = random.float(0.0, total_weight);

        // Find which item this corresponds to
        var cumulative: f64 = 0.0;
        for (items, 0..) |item, i| {
            cumulative += weights[i];
            if (rand_value <= cumulative) {
                return item;
            }
        }

        // Fallback to last item (handles floating point edge cases)
        return items[items.len - 1];
    }

    /// Generate multiple items in a batch
    pub fn batchGenerate(self: *Helpers, comptime T: type, random: *Random, count: usize, generator: *const fn (*Random) T) ![]T {
        var result = try self.allocator.alloc(T, count);
        for (0..count) |i| {
            result[i] = generator(random);
        }
        return result;
    }

    /// Generate a random subset of an array with a given probability for each element
    pub fn subset(self: *Helpers, comptime T: type, random: *Random, items: []const T, probability: f64) ![]T {
        var temp = try std.ArrayList(T).initCapacity(self.allocator, items.len);
        defer temp.deinit();

        for (items) |item| {
            if (self.maybe(random, probability)) {
                try temp.append(item);
            }
        }

        return temp.toOwnedSlice();
    }

    /// Cycle through values in order, wrapping around
    pub const CycleIterator = struct {
        items: []const u8,
        index: usize,

        pub fn init(items: []const u8) CycleIterator {
            return CycleIterator{
                .items = items,
                .index = 0,
            };
        }

        pub fn next(self: *CycleIterator) []const u8 {
            const item = self.items[self.index];
            self.index = (self.index + 1) % self.items.len;
            return &[_]u8{item};
        }
    };

    /// Generate a random value within a normal distribution
    /// Uses Box-Muller transform
    pub fn normalDistribution(self: *Helpers, random: *Random, mean: f64, std_dev: f64) f64 {
        _ = self;
        // Box-Muller transform
        const uniform1 = random.float(0.0, 1.0);
        const uniform2 = random.float(0.0, 1.0);

        const z0 = @sqrt(-2.0 * @log(uniform1)) * @cos(2.0 * std.math.pi * uniform2);
        return mean + z0 * std_dev;
    }

    /// Clamp a value between min and max
    pub fn clamp(self: *Helpers, comptime T: type, value: T, min: T, max: T) T {
        _ = self;
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }

    /// Generate a sequence of numbers
    pub fn sequence(self: *Helpers, start: i64, end: i64, step: i64) ![]i64 {
        if (step == 0) return error.ZeroStep;
        if ((end > start and step < 0) or (end < start and step > 0)) {
            return error.InvalidStepDirection;
        }

        const count = @abs(@divTrunc(end - start, step)) + 1;
        var result = try self.allocator.alloc(i64, @intCast(count));

        var current = start;
        var i: usize = 0;
        while ((step > 0 and current <= end) or (step < 0 and current >= end)) {
            result[i] = current;
            current += step;
            i += 1;
        }

        return result[0..i];
    }

    /// Create a slug from a string (lowercase, replace spaces with dashes)
    pub fn slugify(self: *Helpers, text: []const u8) ![]u8 {
        var result = try self.allocator.alloc(u8, text.len);
        var j: usize = 0;

        for (text) |c| {
            if (c == ' ' or c == '_') {
                if (j > 0 and result[j - 1] != '-') {
                    result[j] = '-';
                    j += 1;
                }
            } else if (std.ascii.isAlphanumeric(c)) {
                result[j] = std.ascii.toLower(c);
                j += 1;
            }
        }

        // Trim trailing dash
        if (j > 0 and result[j - 1] == '-') {
            j -= 1;
        }

        return self.allocator.realloc(result, j);
    }

    /// Generate a random hex color
    pub fn hexColor(self: *Helpers, random: *Random) ![]u8 {
        return std.fmt.allocPrint(
            self.allocator,
            "#{x:0>2}{x:0>2}{x:0>2}",
            .{ random.int(0, 255), random.int(0, 255), random.int(0, 255) },
        );
    }

    /// Repeat a string n times
    pub fn repeatString(self: *Helpers, text: []const u8, count: usize) ![]u8 {
        if (count == 0) return try self.allocator.alloc(u8, 0);

        var result = try self.allocator.alloc(u8, text.len * count);
        for (0..count) |i| {
            const start = i * text.len;
            @memcpy(result[start .. start + text.len], text);
        }
        return result;
    }

    // ==================== Realistic Distribution Helpers ====================

    /// Generate a realistic human age using normal distribution
    /// Default: mean=35, std_dev=15, clamped to 0-100
    pub fn realisticAge(self: *Helpers, random: *Random, mean: ?f64, std_dev: ?f64) i32 {
        const age_mean = mean orelse 35.0;
        const age_std = std_dev orelse 15.0;

        const raw_age = self.normalDistribution(random, age_mean, age_std);
        const clamped = self.clamp(f64, raw_age, 0.0, 100.0);

        return @intFromFloat(clamped);
    }

    /// Generate a realistic adult age (18-80)
    pub fn realisticAdultAge(self: *Helpers, random: *Random) i32 {
        const raw_age = self.normalDistribution(random, 40.0, 12.0);
        const clamped = self.clamp(f64, raw_age, 18.0, 80.0);

        return @intFromFloat(clamped);
    }

    /// Generate a realistic child age (0-17)
    pub fn realisticChildAge(self: *Helpers, random: *Random) i32 {
        const raw_age = self.normalDistribution(random, 8.5, 5.0);
        const clamped = self.clamp(f64, raw_age, 0.0, 17.0);

        return @intFromFloat(clamped);
    }

    /// Generate a realistic senior age (65-100)
    pub fn realisticSeniorAge(self: *Helpers, random: *Random) i32 {
        const raw_age = self.normalDistribution(random, 75.0, 7.0);
        const clamped = self.clamp(f64, raw_age, 65.0, 100.0);

        return @intFromFloat(clamped);
    }
};
