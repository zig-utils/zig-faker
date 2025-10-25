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

    // ==================== Weighted Selection Methods ====================

    /// Generate a weighted first name (uses frequency data if available)
    /// Common names like "James" and "Mary" appear more frequently
    pub fn firstNameWeighted(self: *Person, random: *Random, options: PersonOptions) ![]const u8 {
        const gender_choice = options.gender orelse blk: {
            const rand_val = random.int(0, 2);
            break :blk if (rand_val == 0) Gender.male else if (rand_val == 1) Gender.female else Gender.neutral;
        };

        return switch (gender_choice) {
            .male => blk: {
                if (self.locale.person.first_name_male_weights) |weights| {
                    const Helpers = @import("helpers.zig").Helpers;
                    var helpers = Helpers.init(self.allocator);
                    break :blk try helpers.weightedArrayElement(
                        []const u8,
                        random,
                        self.locale.person.first_name_male,
                        weights
                    );
                } else {
                    break :blk random.arrayElement([]const u8, self.locale.person.first_name_male);
                }
            },
            .female => blk: {
                if (self.locale.person.first_name_female_weights) |weights| {
                    const Helpers = @import("helpers.zig").Helpers;
                    var helpers = Helpers.init(self.allocator);
                    break :blk try helpers.weightedArrayElement(
                        []const u8,
                        random,
                        self.locale.person.first_name_female,
                        weights
                    );
                } else {
                    break :blk random.arrayElement([]const u8, self.locale.person.first_name_female);
                }
            },
            .neutral => random.arrayElement([]const u8, self.locale.person.first_name_neutral),
        };
    }

    /// Generate a weighted last name (uses frequency data if available)
    /// Common surnames like "Smith" and "Johnson" appear more frequently
    pub fn lastNameWeighted(self: *Person, random: *Random) ![]const u8 {
        if (self.locale.person.last_name_weights) |weights| {
            const Helpers = @import("helpers.zig").Helpers;
            var helpers = Helpers.init(self.allocator);
            return helpers.weightedArrayElement(
                []const u8,
                random,
                self.locale.person.last_name,
                weights
            );
        } else {
            return random.arrayElement([]const u8, self.locale.person.last_name);
        }
    }

    /// Generate a realistic full name using weighted selection
    pub fn fullNameWeighted(self: *Person, random: *Random, options: FullNameOptions) ![]u8 {
        var parts = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer parts.deinit(self.allocator);

        if (options.prefix) {
            try parts.append(self.allocator, self.prefix(random));
        }

        const first = try self.firstNameWeighted(random, .{ .gender = options.gender });
        try parts.append(self.allocator, first);

        const last = try self.lastNameWeighted(random);
        try parts.append(self.allocator, last);

        if (options.suffix) {
            try parts.append(self.allocator, self.suffix(random));
        }

        return std.mem.join(self.allocator, " ", parts.items);
    }
};
