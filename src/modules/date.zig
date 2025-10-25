const std = @import("std");
const Random = @import("../random.zig").Random;

pub const DateModule = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) DateModule {
        return DateModule{
            .random = random,
            .allocator = allocator,
        };
    }

    /// Generate a random Unix timestamp
    pub fn timestamp(self: *DateModule) i64 {
        // Random timestamp between 2000-01-01 and 2030-12-31
        const min_timestamp: i64 = 946684800; // 2000-01-01
        const max_timestamp: i64 = 1924905600; // 2030-12-31
        return self.random.int(min_timestamp, max_timestamp);
    }

    /// Generate a past timestamp (within last N days)
    pub fn past(self: *DateModule, days: u32) i64 {
        const now = std.time.timestamp();
        const seconds_per_day: i64 = 86400;
        const max_offset = @as(i64, @intCast(days)) * seconds_per_day;
        const offset = self.random.int(0, max_offset);
        return now - offset;
    }

    /// Generate a future timestamp (within next N days)
    pub fn future(self: *DateModule, days: u32) i64 {
        const now = std.time.timestamp();
        const seconds_per_day: i64 = 86400;
        const max_offset = @as(i64, @intCast(days)) * seconds_per_day;
        const offset = self.random.int(0, max_offset);
        return now + offset;
    }

    /// Generate a recent timestamp (within last 7 days)
    pub fn recent(self: *DateModule) i64 {
        return self.past(7);
    }

    /// Generate a soon timestamp (within next 7 days)
    pub fn soon(self: *DateModule) i64 {
        return self.future(7);
    }

    /// Generate a random weekday name
    pub fn weekday(self: *DateModule) []const u8 {
        const weekdays = [_][]const u8{ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };
        return self.random.arrayElement([]const u8, &weekdays);
    }

    /// Generate a random month name
    pub fn month(self: *DateModule) []const u8 {
        const months = [_][]const u8{
            "January",   "February", "March",    "April",
            "May",       "June",     "July",     "August",
            "September", "October",  "November", "December",
        };
        return self.random.arrayElement([]const u8, &months);
    }

    /// Generate a random date string in YYYY-MM-DD format
    pub fn dateString(self: *DateModule) ![]u8 {
        const year = self.random.int(2000, 2030);
        const month_num = self.random.int(1, 12);
        const day = self.random.int(1, 28); // Safe for all months

        return std.fmt.allocPrint(
            self.allocator,
            "{d:0>4}-{d:0>2}-{d:0>2}",
            .{ year, month_num, day },
        );
    }

    /// Generate a random time string in HH:MM:SS format
    pub fn timeString(self: *DateModule) ![]u8 {
        const hour = self.random.int(0, 23);
        const minute = self.random.int(0, 59);
        const second = self.random.int(0, 59);

        return std.fmt.allocPrint(
            self.allocator,
            "{d:0>2}:{d:0>2}:{d:0>2}",
            .{ hour, minute, second },
        );
    }

    /// Generate a random ISO 8601 datetime string
    pub fn iso8601(self: *DateModule) ![]u8 {
        const date_str = try self.dateString();
        defer self.allocator.free(date_str);

        const time_str = try self.timeString();
        defer self.allocator.free(time_str);

        return std.fmt.allocPrint(
            self.allocator,
            "{s}T{s}Z",
            .{ date_str, time_str },
        );
    }
};
