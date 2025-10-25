const std = @import("std");
const Random = @import("../random.zig").Random;
const LocaleDefinition = @import("../locale.zig").LocaleDefinition;

pub const Internet = struct {
    locale: *const LocaleDefinition,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, locale_def: *const LocaleDefinition) Internet {
        return Internet{
            .locale = locale_def,
            .allocator = allocator,
        };
    }

    /// Generate a domain suffix (.com, .net, etc.)
    pub fn domainSuffix(self: *Internet, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.internet.domain_suffix);
    }

    /// Generate a domain word
    pub fn domainWord(self: *Internet, random: *Random) []const u8 {
        return random.arrayElement([]const u8, self.locale.internet.domain_word);
    }

    /// Generate a domain name
    pub fn domainName(self: *Internet, random: *Random) ![]u8 {
        const word = self.domainWord(random);
        const suffix = self.domainSuffix(random);
        return std.fmt.allocPrint(self.allocator, "{s}.{s}", .{ word, suffix });
    }

    /// Generate an email address
    pub fn email(self: *Internet, random: *Random) ![]u8 {
        const first_name = random.arrayElement([]const u8, self.locale.person.first_name_neutral);
        const last_name = random.arrayElement([]const u8, self.locale.person.last_name);
        const domain = try self.domainName(random);
        defer self.allocator.free(domain);

        // Convert to lowercase
        var lower_first = try self.allocator.alloc(u8, first_name.len);
        defer self.allocator.free(lower_first);
        for (first_name, 0..) |c, i| {
            lower_first[i] = std.ascii.toLower(c);
        }

        var lower_last = try self.allocator.alloc(u8, last_name.len);
        defer self.allocator.free(lower_last);
        for (last_name, 0..) |c, i| {
            lower_last[i] = std.ascii.toLower(c);
        }

        const separator = if (random.boolean(0.5)) "." else "_";
        return std.fmt.allocPrint(
            self.allocator,
            "{s}{s}{s}@{s}",
            .{ lower_first, separator, lower_last, domain },
        );
    }

    /// Generate a free email address (gmail, yahoo, etc.)
    pub fn freeEmail(self: *Internet, random: *Random) ![]u8 {
        const first_name = random.arrayElement([]const u8, self.locale.person.first_name_neutral);
        const last_name = random.arrayElement([]const u8, self.locale.person.last_name);
        const provider = random.arrayElement([]const u8, self.locale.internet.free_email);

        // Convert to lowercase
        var lower_first = try self.allocator.alloc(u8, first_name.len);
        defer self.allocator.free(lower_first);
        for (first_name, 0..) |c, i| {
            lower_first[i] = std.ascii.toLower(c);
        }

        var lower_last = try self.allocator.alloc(u8, last_name.len);
        defer self.allocator.free(lower_last);
        for (last_name, 0..) |c, i| {
            lower_last[i] = std.ascii.toLower(c);
        }

        const separator = if (random.boolean(0.5)) "." else "_";
        const number = random.int(0, 999);

        if (random.boolean(0.3)) {
            return std.fmt.allocPrint(
                self.allocator,
                "{s}{s}{s}{d}@{s}",
                .{ lower_first, separator, lower_last, number, provider },
            );
        }

        return std.fmt.allocPrint(
            self.allocator,
            "{s}{s}{s}@{s}",
            .{ lower_first, separator, lower_last, provider },
        );
    }

    /// Generate a URL
    pub fn url(self: *Internet, random: *Random) ![]u8 {
        const protocol = if (random.boolean(0.8)) "https" else "http";
        const domain = try self.domainName(random);
        defer self.allocator.free(domain);
        return std.fmt.allocPrint(self.allocator, "{s}://{s}", .{ protocol, domain });
    }

    /// Generate a username
    pub fn username(self: *Internet, random: *Random) ![]u8 {
        const first_name = random.arrayElement([]const u8, self.locale.person.first_name_neutral);
        const last_name = random.arrayElement([]const u8, self.locale.person.last_name);

        // Convert to lowercase
        var lower_first = try self.allocator.alloc(u8, first_name.len);
        defer self.allocator.free(lower_first);
        for (first_name, 0..) |c, i| {
            lower_first[i] = std.ascii.toLower(c);
        }

        var lower_last = try self.allocator.alloc(u8, last_name.len);
        defer self.allocator.free(lower_last);
        for (last_name, 0..) |c, i| {
            lower_last[i] = std.ascii.toLower(c);
        }

        const separator_options = [_][]const u8{ "", ".", "_", "-" };
        const separator = random.arrayElement([]const u8, &separator_options);

        if (random.boolean(0.3)) {
            const number = random.int(0, 9999);
            return std.fmt.allocPrint(
                self.allocator,
                "{s}{s}{s}{d}",
                .{ lower_first, separator, lower_last, number },
            );
        }

        return std.fmt.allocPrint(
            self.allocator,
            "{s}{s}{s}",
            .{ lower_first, separator, lower_last },
        );
    }

    /// Generate a password
    pub fn password(self: *Internet, random: *Random, min_length: usize, max_length: usize) ![]u8 {
        const length = @as(usize, @intCast(random.int(@intCast(min_length), @intCast(max_length))));
        const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?";

        var result = try self.allocator.alloc(u8, length);

        for (0..length) |i| {
            const idx = random.int(0, @as(i64, @intCast(chars.len - 1)));
            result[i] = chars[@intCast(idx)];
        }

        return result;
    }
};
