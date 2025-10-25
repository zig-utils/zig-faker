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
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Person {
        return Person{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a random first name
    pub fn firstName(self: *Person, options: PersonOptions) []const u8 {
        const gender_choice = options.gender orelse blk: {
            const rand_val = self.random.int(0, 2);
            break :blk if (rand_val == 0) Gender.male else if (rand_val == 1) Gender.female else Gender.neutral;
        };

        return switch (gender_choice) {
            .male => self.random.arrayElement([]const u8, self.locale.person.first_name_male),
            .female => self.random.arrayElement([]const u8, self.locale.person.first_name_female),
            .neutral => self.random.arrayElement([]const u8, self.locale.person.first_name_neutral),
        };
    }

    /// Generate a random last name
    pub fn lastName(self: *Person) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.person.last_name);
    }

    /// Generate a full name
    pub fn fullName(self: *Person, options: FullNameOptions) ![]u8 {
        var parts = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer parts.deinit(self.allocator);

        if (options.prefix) {
            try parts.append(self.allocator, self.prefix());
        }

        const first = self.firstName(.{ .gender = options.gender });
        try parts.append(self.allocator, first);

        const last = self.lastName();
        try parts.append(self.allocator, last);

        if (options.suffix) {
            try parts.append(self.allocator, self.suffix());
        }

        return std.mem.join(self.allocator, " ", parts.items);
    }

    /// Generate a name prefix (Mr., Mrs., etc.)
    pub fn prefix(self: *Person) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.person.prefix);
    }

    /// Generate a name suffix (Jr., Sr., etc.)
    pub fn suffix(self: *Person) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.person.suffix);
    }

    /// Generate a random gender
    pub fn gender(self: *Person) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.person.gender);
    }

    /// Generate a random job title
    pub fn jobTitle(self: *Person) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.person.job_title);
    }
};
