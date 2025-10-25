const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Food = struct {
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Food {
        return Food{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a random dish name
    pub fn dish(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.dish);
        }
        return "Unknown Dish";
    }

    /// Generate a random ingredient
    pub fn ingredient(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.ingredient);
        }
        return "Unknown Ingredient";
    }

    /// Generate a random fruit
    pub fn fruit(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.fruit);
        }
        return "Apple";
    }

    /// Generate a random vegetable
    pub fn vegetable(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.vegetable);
        }
        return "Carrot";
    }

    /// Generate a random meat
    pub fn meat(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.meat);
        }
        return "Chicken";
    }

    /// Generate a random spice
    pub fn spice(self: *Food) []const u8 {
        if (self.locale.food) |food_locale| {
            return self.random.arrayElement([]const u8, food_locale.spice);
        }
        return "Salt";
    }

    /// Generate a random recipe name
    pub fn recipe(self: *Food) ![]u8 {
        const descriptor = [_][]const u8{ "Grilled", "Baked", "Fried", "Roasted", "Steamed", "Sauteed", "Braised", "Smoked" };
        const desc = self.random.arrayElement([]const u8, &descriptor);
        const main_ingredient = self.meat();

        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ desc, main_ingredient });
    }
};
