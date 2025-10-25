const std = @import("std");
const Random = @import("../random.zig").Random;

pub const NumberModule = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) NumberModule {
        return NumberModule{
            .random = random,
            .allocator = allocator,
        };
    }

    /// Generate a random integer in range [min, max]
    pub fn int(self: *NumberModule, min: i64, max: i64) i64 {
        return self.random.int(min, max);
    }

    /// Generate a random float in range [min, max]
    pub fn float(self: *NumberModule, min: f64, max: f64) f64 {
        return self.random.float(min, max);
    }

    /// Generate a random percentage (0.0 to 100.0)
    pub fn percentage(self: *NumberModule, precision: u8) f64 {
        const value = self.random.float(0.0, 100.0);
        const multiplier = std.math.pow(f64, 10.0, @floatFromInt(precision));
        return @round(value * multiplier) / multiplier;
    }

    /// Generate a random binary number string
    pub fn binary(self: *NumberModule, length: usize) ![]u8 {
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            result[i] = if (self.random.boolean(0.5)) '1' else '0';
        }

        return result;
    }

    /// Generate a random octal number string
    pub fn octal(self: *NumberModule, length: usize) ![]u8 {
        const octal_chars = "01234567";
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = self.random.int(0, 7);
            result[i] = octal_chars[@intCast(idx)];
        }

        return result;
    }

    /// Generate a random hexadecimal number string
    pub fn hexadecimal(self: *NumberModule, length: usize) ![]u8 {
        return self.random.hex(self.allocator, length);
    }

    /// Generate a random prime number up to max
    pub fn prime(self: *NumberModule, max: u32) u32 {
        const primes = [_]u32{
            2,   3,   5,   7,   11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  53,
            59,  61,  67,  71,  73,  79,  83,  89,  97,  101, 103, 107, 109, 113, 127, 131,
            137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223,
            227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311,
            313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409,
        };

        // Filter primes up to max
        var count: usize = 0;
        for (primes) |p| {
            if (p <= max) count += 1 else break;
        }

        if (count == 0) return 2;

        const idx = self.random.int(0, @as(i64, @intCast(count - 1)));
        return primes[@intCast(idx)];
    }

    /// Generate a random even number in range
    pub fn even(self: *NumberModule, min: i64, max: i64) i64 {
        var value = self.random.int(min, max);
        if (@mod(value, 2) != 0) {
            if (value < max) {
                value += 1;
            } else {
                value -= 1;
            }
        }
        return value;
    }

    /// Generate a random odd number in range
    pub fn odd(self: *NumberModule, min: i64, max: i64) i64 {
        var value = self.random.int(min, max);
        if (@mod(value, 2) == 0) {
            if (value < max) {
                value += 1;
            } else {
                value -= 1;
            }
        }
        return value;
    }
};
