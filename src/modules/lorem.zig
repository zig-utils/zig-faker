const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Lorem = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Lorem {
        return Lorem{
            .allocator = allocator,
        };
    }

    /// Lorem ipsum word list
    const lorem_words = [_][]const u8{
        "lorem",      "ipsum",      "dolor",      "sit",        "amet",       "consectetur",
        "adipiscing", "elit",       "sed",        "do",         "eiusmod",    "tempor",
        "incididunt", "ut",         "labore",     "et",         "dolore",     "magna",
        "aliqua",     "enim",       "ad",         "minim",      "veniam",     "quis",
        "nostrud",    "exercitation", "ullamco",  "laboris",    "nisi",       "aliquip",
        "ex",         "ea",         "commodo",    "consequat",  "duis",       "aute",
        "irure",      "in",         "reprehenderit", "voluptate", "velit",   "esse",
        "cillum",     "fugiat",     "nulla",      "pariatur",   "excepteur",  "sint",
        "occaecat",   "cupidatat",  "non",        "proident",   "sunt",       "culpa",
        "qui",        "officia",    "deserunt",   "mollit",     "anim",       "id",
        "est",        "laborum",
    };

    /// Generate a single random word
    pub fn word(self: *Lorem, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &lorem_words);
    }

    /// Generate multiple words
    pub fn words(self: *Lorem, random: *Random, count: usize) ![]u8 {
        var result = std.ArrayList([]const u8).initCapacity(self.allocator, count) catch unreachable;
        defer result.deinit(self.allocator);

        for (0..count) |_| {
            try result.append(self.allocator, self.word(random));
        }

        return std.mem.join(self.allocator, " ", result.items);
    }

    /// Generate a sentence (10-20 words)
    pub fn sentence(self: *Lorem, random: *Random) ![]u8 {
        const word_count = @as(usize, @intCast(random.int(10, 20)));
        const sentence_words = try self.words(random, word_count);
        defer self.allocator.free(sentence_words);

        // Capitalize first letter and add period
        var result = try self.allocator.alloc(u8, sentence_words.len + 1);
        @memcpy(result[0..sentence_words.len], sentence_words);
        result[0] = std.ascii.toUpper(result[0]);
        result[sentence_words.len] = '.';

        return result;
    }

    /// Generate multiple sentences
    pub fn sentences(self: *Lorem, random: *Random, count: usize) ![]u8 {
        var result = try std.ArrayList(u8).initCapacity(self.allocator, count * 50);
        defer result.deinit(self.allocator);

        for (0..count) |i| {
            const sent = try self.sentence(random);
            defer self.allocator.free(sent);

            try result.appendSlice(self.allocator, sent);
            if (i < count - 1) {
                try result.append(self.allocator, ' ');
            }
        }

        return result.toOwnedSlice(self.allocator);
    }

    /// Generate a paragraph (3-7 sentences)
    pub fn paragraph(self: *Lorem, random: *Random) ![]u8 {
        const sentence_count = @as(usize, @intCast(random.int(3, 7)));
        return self.sentences(random, sentence_count);
    }

    /// Generate multiple paragraphs
    pub fn paragraphs(self: *Lorem, random: *Random, count: usize) ![]u8 {
        var result = std.ArrayList(u8).init(self.allocator);
        defer result.deinit(self.allocator);

        for (0..count) |i| {
            const para = try self.paragraph(random);
            defer self.allocator.free(para);

            try result.appendSlice(self.allocator, para);
            if (i < count - 1) {
                try result.appendSlice(self.allocator, "\n\n");
            }
        }

        return result.toOwnedSlice(self.allocator);
    }

    /// Generate text with specified line count
    pub fn lines(self: *Lorem, random: *Random, count: usize) ![]u8 {
        var result = std.ArrayList(u8).init(self.allocator);
        defer result.deinit(self.allocator);

        for (0..count) |i| {
            const sent = try self.sentence(random);
            defer self.allocator.free(sent);

            try result.appendSlice(self.allocator, sent);
            if (i < count - 1) {
                try result.append(self.allocator, '\n');
            }
        }

        return result.toOwnedSlice(self.allocator);
    }

    /// Generate a slug (lowercase words separated by hyphens)
    pub fn slug(self: *Lorem, random: *Random, word_count: usize) ![]u8 {
        var result = std.ArrayList([]const u8).initCapacity(self.allocator, word_count) catch unreachable;
        defer result.deinit(self.allocator);

        for (0..word_count) |_| {
            try result.append(self.allocator, self.word(random));
        }

        return std.mem.join(self.allocator, "-", result.items);
    }

    /// Generate text with specified character count (approximate)
    pub fn text(self: *Lorem, random: *Random, char_count: usize) ![]u8 {
        var result = std.ArrayList(u8).init(self.allocator);
        defer result.deinit(self.allocator);

        while (result.items.len < char_count) {
            const w = self.word(random);
            try result.appendSlice(self.allocator, w);

            if (result.items.len < char_count) {
                try result.append(self.allocator, ' ');
            }
        }

        // Trim to exact length
        const final = try self.allocator.alloc(u8, @min(char_count, result.items.len));
        @memcpy(final, result.items[0..final.len]);
        return final;
    }
};
