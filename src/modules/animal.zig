const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Animal = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Animal {
        return Animal{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a random dog breed
    pub fn dog(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.dog);
        }
        return "Labrador";
    }

    /// Generate a random cat breed
    pub fn cat(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.cat);
        }
        return "Persian";
    }

    /// Generate a random bird species
    pub fn bird(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.bird);
        }
        return "Robin";
    }

    /// Generate a random fish species
    pub fn fish(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.fish);
        }
        return "Goldfish";
    }

    /// Generate a random animal type
    pub fn type_(self: *Animal, random: *Random) []const u8 {
        _ = self;
        const types = [_][]const u8{ "Mammal", "Bird", "Fish", "Reptile", "Amphibian", "Insect" };
        return random.arrayElement([]const u8, &types);
    }

    /// Generate a random horse breed
    pub fn horse(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.horse);
        }
        return "Arabian";
    }

    /// Generate a random farm animal
    pub fn farm(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.farm);
        }
        return "Cow";
    }

    /// Generate a random insect
    pub fn insect(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.insect);
        }
        return "Ant";
    }

    /// Generate a random wild animal
    pub fn wild(self: *Animal, random: *Random) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return random.arrayElement([]const u8, animal_locale.wild);
        }
        return "Lion";
    }

    /// Generate a random pet name
    pub fn petName(self: *Animal, random: *Random) []const u8 {
        _ = self;
        const names = [_][]const u8{
            "Max",     "Bella",   "Charlie", "Lucy",    "Cooper",  "Luna",    "Buddy",   "Daisy",
            "Milo",    "Sadie",   "Rocky",   "Molly",   "Tucker",  "Lola",    "Bear",    "Sophie",
            "Duke",    "Maggie",  "Zeus",    "Chloe",   "Jack",    "Bailey",  "Oliver",  "Zoe",
            "Bentley", "Lily",    "Toby",    "Penny",   "Oscar",   "Gracie",  "Leo",     "Ruby",
        };
        return random.arrayElement([]const u8, &names);
    }
};
