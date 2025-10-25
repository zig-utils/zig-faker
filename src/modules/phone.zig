const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Phone = struct {
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Phone {
        return Phone{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a phone number
    pub fn phoneNumber(self: *Phone) ![]u8 {
        const format = self.random.arrayElement([]const u8, self.locale.phone.format);
        return self.random.replaceSymbols(self.allocator, format);
    }
};
