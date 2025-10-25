const std = @import("std");
const Random = @import("../random.zig").Random;

pub const StringModule = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) StringModule {
        return StringModule{
            .random = random,
            .allocator = allocator,
        };
    }

    /// Generate a UUID v4
    pub fn uuid(self: *StringModule) ![]u8 {
        var result = try self.allocator.alloc(u8, 36);

        // Format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
        const hex_chars = "0123456789abcdef";

        var i: usize = 0;
        while (i < 36) : (i += 1) {
            if (i == 8 or i == 13 or i == 18 or i == 23) {
                result[i] = '-';
            } else if (i == 14) {
                result[i] = '4'; // UUID version 4
            } else if (i == 19) {
                // The variant bits
                const idx = self.random.int(0, 3);
                result[i] = "89ab"[@intCast(idx)];
            } else {
                const idx = self.random.int(0, 15);
                result[i] = hex_chars[@intCast(idx)];
            }
        }

        return result;
    }

    /// Generate a nanoid (URL-friendly unique ID)
    pub fn nanoid(self: *StringModule, length: usize) ![]u8 {
        const alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-";
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = self.random.int(0, @as(i64, @intCast(alphabet.len - 1)));
            result[i] = alphabet[@intCast(idx)];
        }

        return result;
    }

    /// Generate a random alphanumeric string
    pub fn alphanumeric(self: *StringModule, length: usize) ![]u8 {
        const chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = self.random.int(0, @as(i64, @intCast(chars.len - 1)));
            result[i] = chars[@intCast(idx)];
        }

        return result;
    }

    /// Generate a random alphabetic string
    pub fn alpha(self: *StringModule, length: usize) ![]u8 {
        const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = self.random.int(0, @as(i64, @intCast(chars.len - 1)));
            result[i] = chars[@intCast(idx)];
        }

        return result;
    }

    /// Generate a random numeric string
    pub fn numeric(self: *StringModule, length: usize) ![]u8 {
        const chars = "0123456789";
        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = self.random.int(0, 9);
            result[i] = chars[@intCast(idx)];
        }

        return result;
    }

    /// Generate a hexadecimal string
    pub fn hexadecimal(self: *StringModule, length: usize) ![]u8 {
        return self.random.hex(self.allocator, length);
    }
};
