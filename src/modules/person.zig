const std = @import("std");
const Random = @import("../random.zig").Random;
const locale_mod = @import("../locale.zig");
const LocaleDefinition = locale_mod.LocaleDefinition;
const Gender = locale_mod.Gender;

pub const PersonOptions = struct {
    gender: ?Gender = null,
};

pub const FullNameOptions = struct {
    prefix: bool = false,
    suffix: bool = false,
    gender: ?Gender = null,
};

pub const Person = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Person {
        return Person{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a random first name
    pub fn firstName(self: *Person, random: *Random, options: PersonOptions) []const u8 {
        const gender_choice = options.gender orelse blk: {
            const rand_val = random.int(0, 2);
            break :blk if (rand_val == 0) Gender.male else if (rand_val == 1) Gender.female else Gender.neutral;
        };

        return switch (gender_choice) {
            .male => random.arrayElement([]const u8, self.locale.person.first_name_male),
            .female => random.arrayElement([]const u8, self.locale.person.first_name_female),
            .neutral => random.arrayElement([]const u8, self.locale.person.first_name_neutral),
        };
    }

    /// Generate a random last name
    pub fn lastName(self: *Person, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.person.last_name);
    }

    /// Generate a full name
    pub fn fullName(self: *Person, random: *Random, options: FullNameOptions) ![]u8 {
        var parts = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer parts.deinit(self.allocator);

        if (options.prefix) {
            try parts.append(self.allocator, self.prefix(random));
        }

        const first = self.firstName(random, .{ .gender = options.gender });
        try parts.append(self.allocator, first);

        const last = self.lastName(random);
        try parts.append(self.allocator, last);

        if (options.suffix) {
            try parts.append(self.allocator, self.suffix(random));
        }

        return std.mem.join(self.allocator, " ", parts.items);
    }

    /// Generate a name prefix (Mr., Mrs., etc.)
    pub fn prefix(self: *Person, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.person.prefix);
    }

    /// Generate a name suffix (Jr., Sr., etc.)
    pub fn suffix(self: *Person, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.person.suffix);
    }

    /// Generate a random gender
    pub fn gender(self: *Person, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.person.gender);
    }

    /// Generate a random job title
    pub fn jobTitle(self: *Person, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.person.job_title);
    }
};
