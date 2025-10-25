const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Company = struct {
    random: *Random,
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random, locale_def: *const LocaleDefinition) Company {
        return Company{
            .random = random,
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a company name
    pub fn name(self: *Company) ![]u8 {
        const company_name = self.random.arrayElement([]const u8, self.locale.company.name);
        const suffix_str = self.suffix();
        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ company_name, suffix_str });
    }

    /// Generate a company suffix (Inc, LLC, etc.)
    pub fn suffix(self: *Company) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.company.suffix);
    }

    /// Generate an industry name
    pub fn industry(self: *Company) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.company.industry);
    }

    /// Generate a business buzzword
    pub fn buzzword(self: *Company) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.company.buzzwords);
    }

    /// Generate a company descriptor
    pub fn descriptor(self: *Company) []const u8 {
        return self.random.arrayElement([]const u8, self.locale.company.descriptor);
    }

    /// Generate a business phrase
    pub fn catchPhrase(self: *Company) ![]u8 {
        const descriptor_str = self.descriptor();
        const buzzword_str = self.buzzword();
        const industry_str = self.industry();
        return std.fmt.allocPrint(
            self.allocator,
            "{s} {s} {s}",
            .{ descriptor_str, buzzword_str, industry_str },
        );
    }
};
