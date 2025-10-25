const std = @import("std");

/// Random number generator with optional seeding support
/// Uses Linear Congruential Generator when seeded: (seed * 9301 + 49297) % 233280
pub const Random = struct {
    seed_value: ?u64,
    rng: std.Random,
    prng: std.Random.DefaultPrng,

    pub fn init(seed: ?u64) Random {
        if (seed) |s| {
            var prng = std.Random.DefaultPrng.init(s);
            return Random{
                .seed_value = s,
                .rng = prng.random(),
                .prng = prng,
            };
        } else {
            var prng = std.Random.DefaultPrng.init(blk: {
                var seed_bytes: [8]u8 = undefined;
                std.crypto.random.bytes(&seed_bytes);
                break :blk std.mem.readInt(u64, &seed_bytes, .little);
            });
            return Random{
                .seed_value = null,
                .rng = prng.random(),
                .prng = prng,
            };
        }
    }

    /// Generate a random float between 0.0 and 1.0
    pub fn number(self: *Random) f64 {
        return self.rng.float(f64);
    }

    /// Generate a random integer in the range [min, max] inclusive
    pub fn int(self: *Random, min: i64, max: i64) i64 {
        if (min == max) return min;
        const range = @abs(max - min) + 1;
        return min + @as(i64, @intCast(self.rng.uintLessThan(u64, @intCast(range))));
    }

    /// Generate a random float in the range [min, max]
    pub fn float(self: *Random, min: f64, max: f64) f64 {
        return min + (max - min) * self.number();
    }

    /// Pick a random element from a slice
    pub fn arrayElement(self: *Random, comptime T: type, array: []const T) T {
        if (array.len == 0) @panic("Cannot pick from empty array");
        const index = self.rng.uintLessThan(usize, array.len);
        return array[index];
    }

    /// Pick multiple random elements from a slice
    pub fn arrayElements(self: *Random, comptime T: type, allocator: std.mem.Allocator, array: []const T, count: usize) ![]T {
        if (count > array.len) return error.CountExceedsArrayLength;

        var result = try allocator.alloc(T, count);
        var used = try allocator.alloc(bool, array.len);
        defer allocator.free(used);

        @memset(used, false);

        var i: usize = 0;
        while (i < count) {
            const index = self.rng.uintLessThan(usize, array.len);
            if (!used[index]) {
                result[i] = array[index];
                used[index] = true;
                i += 1;
            }
        }

        return result;
    }

    /// Shuffle an array using Fisher-Yates algorithm
    pub fn shuffle(self: *Random, comptime T: type, array: []T) void {
        if (array.len < 2) return;

        var i = array.len - 1;
        while (i > 0) : (i -= 1) {
            const j = self.rng.uintLessThan(usize, i + 1);
            const temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }

    /// Generate a random boolean with optional weight (0.0 to 1.0, default 0.5)
    pub fn boolean(self: *Random, weight: f64) bool {
        return self.number() < weight;
    }

    /// Replace # with digits and ? with letters in a format string
    pub fn replaceSymbols(self: *Random, allocator: std.mem.Allocator, format: []const u8) ![]u8 {
        var result = try allocator.alloc(u8, format.len);

        for (format, 0..) |c, i| {
            result[i] = switch (c) {
                '#' => '0' + @as(u8, @intCast(self.rng.uintLessThan(u8, 10))),
                '?' => blk: {
                    const is_upper = self.boolean(0.5);
                    const letter = @as(u8, @intCast(self.rng.uintLessThan(u8, 26)));
                    break :blk if (is_upper) 'A' + letter else 'a' + letter;
                },
                else => c,
            };
        }

        return result;
    }

    /// Generate a hexadecimal string of specified length
    pub fn hex(self: *Random, allocator: std.mem.Allocator, length: usize) ![]u8 {
        const hex_chars = "0123456789abcdef";
        var result = try allocator.alloc(u8, length);

        for (0..length) |i| {
            result[i] = hex_chars[self.rng.uintLessThan(usize, 16)];
        }

        return result;
    }
};
