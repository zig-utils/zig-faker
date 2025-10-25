const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const StreetAddressOptions = struct {
    use_full_address: bool = false,
};

pub const Address = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Address {
        return Address{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a street name
    pub fn streetName(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.street_name);
    }

    /// Generate a building number
    pub fn buildingNumber(self: *Address, random: *Random) ![]u8 {
        const format = random.arrayElement([]const u8, self.locale.address.building_number);
        return random.replaceSymbols(self.allocator, format);
    }

    /// Generate a street address
    pub fn streetAddress(self: *Address, random: *Random, options: StreetAddressOptions) ![]u8 {
        const building = try self.buildingNumber(random);
        defer self.allocator.free(building);

        const street = self.streetName(random);

        if (options.use_full_address) {
            const direction_str = self.direction(random);
            return std.fmt.allocPrint(self.allocator, "{s} {s} {s}", .{ building, direction_str, street });
        }

        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ building, street });
    }

    /// Generate a city name
    pub fn city(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.city);
    }

    /// Generate a state name
    pub fn state(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.state);
    }

    /// Generate a state abbreviation
    pub fn stateAbbr(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.state_abbr);
    }

    /// Generate a country name
    pub fn country(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.country);
    }

    /// Generate a postal code
    pub fn postalCode(self: *Address, random: *Random) ![]u8 {
        const format = random.arrayElement([]const u8, self.locale.address.postal_code_format);
        return random.replaceSymbols(self.allocator, format);
    }

    /// Generate a direction (North, South, etc.)
    pub fn direction(self: *Address, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.address.direction);
    }

    /// Generate a full address
    pub fn fullAddress(self: *Address, random: *Random) ![]u8 {
        const street = try self.streetAddress(random, .{ .use_full_address = false });
        defer self.allocator.free(street);

        const city_name = self.city(random);
        const state_abbr = self.stateAbbr(random);
        const zip = try self.postalCode(random);
        defer self.allocator.free(zip);

        return std.fmt.allocPrint(
            self.allocator,
            "{s}, {s}, {s} {s}",
            .{ street, city_name, state_abbr, zip },
        );
    }

    // ==================== Weighted Selection Methods ====================

    /// Generate a weighted country name (uses population data if available)
    /// More populous countries like China and India appear more frequently
    pub fn countryWeighted(self: *Address, random: *Random) ![]const u8 {
        if (self.locale.address.country_weights) |weights| {
            const Helpers = @import("helpers.zig").Helpers;
            var helpers = Helpers.init(self.allocator);
            return helpers.weightedArrayElement(
                []const u8,
                random,
                self.locale.address.country,
                weights
            );
        } else {
            return random.arrayElement([]const u8, self.locale.address.country);
        }
    }
};
