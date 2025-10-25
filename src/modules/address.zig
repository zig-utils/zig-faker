const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const StreetAddressOptions = struct {
    use_full_address: bool = false,
};

pub const Address = struct {
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Address {
        return Address{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a street name
    pub fn streetName(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.street_name);
    }

    /// Generate a building number
    pub fn buildingNumber(self: *Address) ![]u8 {
        const format = self.random.arrayElement([]const u8, self.locale.address.building_number);
        return self.random.replaceSymbols(self.allocator, format);
    }

    /// Generate a street address
    pub fn streetAddress(self: *Address, options: StreetAddressOptions) ![]u8 {
        const building = try self.buildingNumber();
        defer self.allocator.free(building);

        const street = self.streetName();

        if (options.use_full_address) {
            const direction_str = self.direction();
            return std.fmt.allocPrint(self.allocator, "{s} {s} {s}", .{ building, direction_str, street });
        }

        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ building, street });
    }

    /// Generate a city name
    pub fn city(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.city);
    }

    /// Generate a state name
    pub fn state(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.state);
    }

    /// Generate a state abbreviation
    pub fn stateAbbr(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.state_abbr);
    }

    /// Generate a country name
    pub fn country(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.country);
    }

    /// Generate a postal code
    pub fn postalCode(self: *Address) ![]u8 {
        const format = self.random.arrayElement([]const u8, self.locale.address.postal_code_format);
        return self.random.replaceSymbols(self.allocator, format);
    }

    /// Generate a direction (North, South, etc.)
    pub fn direction(self: *Address) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.address.direction);
    }

    /// Generate a full address
    pub fn fullAddress(self: *Address) ![]u8 {
        const street = try self.streetAddress(.{ .use_full_address = false });
        defer self.allocator.free(street);

        const city_name = self.city();
        const state_abbr = self.stateAbbr();
        const zip = try self.postalCode();
        defer self.allocator.free(zip);

        return std.fmt.allocPrint(
            self.allocator,
            "{s}, {s}, {s} {s}",
            .{ street, city_name, state_abbr, zip },
        );
    }
};
