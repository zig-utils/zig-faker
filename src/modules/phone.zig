const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Phone = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Phone {
        return Phone{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a phone number
    pub fn phoneNumber(self: *Phone, random: *Random) ![]u8 {
        const format = random.arrayElement([]const u8, self.locale.phone.format);
        return random.replaceSymbols(self.allocator, format);
    }
};
