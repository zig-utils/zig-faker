const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Company = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Company {
        return Company{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a company name
    pub fn name(self: *Company, random: *Random) ![]u8 {
        const company_name = random.arrayElement([]const u8, self.locale.company.name);
        const suffix_str = self.suffix(random);
        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ company_name, suffix_str });
    }

    /// Generate a company suffix (Inc, LLC, etc.)
    pub fn suffix(self: *Company, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.company.suffix);
    }

    /// Generate an industry name
    pub fn industry(self: *Company, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.company.industry);
    }

    /// Generate a business buzzword
    pub fn buzzword(self: *Company, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.company.buzzwords);
    }

    /// Generate a company descriptor
    pub fn descriptor(self: *Company, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.company.descriptor);
    }

    /// Generate a business phrase
    pub fn catchPhrase(self: *Company, random: *Random) ![]u8 {
        const descriptor_str = self.descriptor(random);
        const buzzword_str = self.buzzword(random);
        const industry_str = self.industry(random);
        return std.fmt.allocPrint(
            self.allocator,
            "{s} {s} {s}",
            .{ descriptor_str, buzzword_str, industry_str },
        );
    }
};
