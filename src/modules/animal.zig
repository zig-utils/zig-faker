const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Animal = struct {
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Animal {
        return Animal{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a random dog breed
    pub fn dog(self: *Animal) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return self.random.arrayElement([]const u8, animal_locale.dog);
        }
        return "Labrador";
    }

    /// Generate a random cat breed
    pub fn cat(self: *Animal) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return self.random.arrayElement([]const u8, animal_locale.cat);
        }
        return "Persian";
    }

    /// Generate a random bird species
    pub fn bird(self: *Animal) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return self.random.arrayElement([]const u8, animal_locale.bird);
        }
        return "Robin";
    }

    /// Generate a random fish species
    pub fn fish(self: *Animal) []const u8 {
        if (self.locale.animal) |animal_locale| {
            return self.random.arrayElement([]const u8, animal_locale.fish);
        }
        return "Goldfish";
    }

    /// Generate a random animal type
    pub fn type_(self: *Animal) []const u8 {
        const types = [_][]const u8{ "Mammal", "Bird", "Fish", "Reptile", "Amphibian", "Insect" };
        return self.random.arrayElement([]const u8, &types);
    }

    /// Generate a random pet name
    pub fn petName(self: *Animal) []const u8 {
        const names = [_][]const u8{
            "Max",     "Bella",   "Charlie", "Lucy",    "Cooper",  "Luna",    "Buddy",   "Daisy",
            "Milo",    "Sadie",   "Rocky",   "Molly",   "Tucker",  "Lola",    "Bear",    "Sophie",
            "Duke",    "Maggie",  "Zeus",    "Chloe",   "Jack",    "Bailey",  "Oliver",  "Zoe",
            "Bentley", "Lily",    "Toby",    "Penny",   "Oscar",   "Gracie",  "Leo",     "Ruby",
        };
        return self.random.arrayElement([]const u8, &names);
    }
};
