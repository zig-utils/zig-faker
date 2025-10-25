const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Hacker = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Hacker {
        return Hacker{
            .allocator = allocator,
        };
    }

    const abbreviations = [_][]const u8{
        "AES",   "API",   "ASCII", "AI",    "BLOB",  "CLI",   "CPU",   "CSS",
        "CSV",   "DNS",   "DOM",   "EXE",   "FTP",   "GB",    "GPU",   "GUI",
        "HTML",  "HTTP",  "HTTPS", "IP",    "IPS",   "ISP",   "JSON",  "LAN",
        "MB",    "RAM",   "REST",  "ROM",   "RSS",   "SAS",   "SCSI",  "SDK",
        "SMTP",  "SQL",   "SSH",   "SSL",   "TCP",   "TLS",   "UDP",   "UI",
        "URL",   "USB",   "UTF",   "VPN",   "WAN",   "WWW",   "XML",   "XSS",
    };

    const adjectives = [_][]const u8{
        "auxiliary",    "primary",      "back-end",     "digital",      "open-source",
        "virtual",      "cross-platform", "redundant",  "online",       "haptic",
        "multi-byte",   "bluetooth",    "wireless",     "1080p",        "neural",
        "optical",      "solid state",  "mobile",       "quantum",      "distributed",
    };

    const nouns = [_][]const u8{
        "driver",    "protocol",   "bandwidth",  "panel",      "microchip",
        "program",   "port",       "card",       "array",      "interface",
        "system",    "sensor",     "firewall",   "hard drive", "pixel",
        "alarm",     "feed",       "monitor",    "application", "transmitter",
        "bus",       "circuit",    "capacitor",  "matrix",     "server",
    };

    const verbs = [_][]const u8{
        "back up",    "bypass",     "hack",       "override",   "compress",
        "copy",       "navigate",   "index",      "connect",    "generate",
        "quantify",   "calculate",  "synthesize", "input",      "transmit",
        "program",    "reboot",     "parse",      "encrypt",    "decrypt",
    };

    const ingverbs = [_][]const u8{
        "backing up",   "bypassing",    "hacking",      "overriding",   "compressing",
        "copying",      "navigating",   "indexing",     "connecting",   "generating",
        "quantifying",  "calculating",  "synthesizing", "inputting",    "transmitting",
        "programming",  "rebooting",    "parsing",      "encrypting",   "decrypting",
    };

    /// Generate a random tech abbreviation
    pub fn abbreviation(self: *Hacker, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &abbreviations);
    }

    /// Generate a random tech adjective
    pub fn adjective(self: *Hacker, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &adjectives);
    }

    /// Generate a random tech noun
    pub fn noun(self: *Hacker, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &nouns);
    }

    /// Generate a random tech verb
    pub fn verb(self: *Hacker, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &verbs);
    }

    /// Generate a random tech -ing verb
    pub fn ingverb(self: *Hacker, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &ingverbs);
    }

    /// Generate a tech phrase
    pub fn phrase(self: *Hacker, random: *Random) ![]u8 {
        const patterns = [_][]const u8{
            "If we {verb} the {noun}, we can get to the {abbreviation} {noun} through the {adjective} {abbreviation} {noun}!",
            "We need to {verb} the {adjective} {abbreviation} {noun}!",
            "Try to {verb} the {abbreviation} {noun}, maybe it will {verb} the {adjective} {noun}!",
            "You can't {verb} the {noun} without {ingverb} the {adjective} {abbreviation} {noun}!",
            "Use the {adjective} {abbreviation} {noun}, then you can {verb} the {adjective} {noun}!",
            "The {abbreviation} {noun} is down, {verb} the {adjective} {noun} so we can {verb} the {abbreviation} {noun}!",
            "{ingverb} the {noun} won't do anything, we need to {verb} the {adjective} {abbreviation} {noun}!",
            "I'll {verb} the {adjective} {abbreviation} {noun}, that should {verb} the {abbreviation} {noun}!",
        };

        const pattern = random.arrayElement([]const u8, &patterns);
        var result = try self.allocator.dupe(u8, pattern);

        // Replace placeholders
        result = try self.replacePlaceholder(random, result, "{verb}", self.verb(random));
        result = try self.replacePlaceholder(random, result, "{noun}", self.noun(random));
        result = try self.replacePlaceholder(random, result, "{abbreviation}", self.abbreviation(random));
        result = try self.replacePlaceholder(random, result, "{adjective}", self.adjective(random));
        result = try self.replacePlaceholder(random, result, "{ingverb}", self.ingverb(random));

        return result;
    }

    fn replacePlaceholder(self: *Hacker, random: *Random, text: []u8, placeholder: []const u8, replacement: []const u8) ![]u8 {
        _ = random;
        var result = try std.ArrayList(u8).initCapacity(self.allocator, text.len + replacement.len);
        defer result.deinit(self.allocator);

        var i: usize = 0;
        while (i < text.len) {
            if (i + placeholder.len <= text.len and std.mem.eql(u8, text[i .. i + placeholder.len], placeholder)) {
                try result.appendSlice(self.allocator, replacement);
                i += placeholder.len;
            } else {
                try result.append(self.allocator, text[i]);
                i += 1;
            }
        }

        self.allocator.free(text);
        return result.toOwnedSlice(self.allocator);
    }
};
