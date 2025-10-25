const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Color = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Color {
        return Color{
            .allocator = allocator,
        };
    }

    /// Generate a random color name
    pub fn name(self: *Color, random: *Random) []const u8 {
        _ = self;
        const colors = [_][]const u8{
            "Red",       "Blue",      "Green",     "Yellow",    "Orange",    "Purple",    "Pink",
            "Brown",     "Black",     "White",     "Gray",      "Silver",    "Gold",      "Cyan",
            "Magenta",   "Lime",      "Indigo",    "Violet",    "Turquoise", "Teal",      "Navy",
            "Maroon",    "Olive",     "Aqua",      "Fuchsia",   "Beige",     "Tan",       "Khaki",
            "Ivory",     "Cream",     "Crimson",   "Scarlet",   "Ruby",      "Coral",     "Salmon",
            "Peach",     "Amber",     "Apricot",   "Lavender",  "Plum",      "Periwinkle", "Mint",
            "Emerald",   "Jade",      "Sage",      "Azure",     "Cobalt",    "Sapphire",  "Slate",
            "Charcoal",  "Ebony",     "Pearl",     "Snow",      "Ash",       "Steel",     "Bronze",
        };
        return random.arrayElement([]const u8, &colors);
    }

    /// Generate a random hex color (e.g., "#FF5733")
    pub fn hex(self: *Color, random: *Random) ![]u8 {
        const hex_str = try random.hex(self.allocator, 6);
        defer self.allocator.free(hex_str);

        return std.fmt.allocPrint(self.allocator, "#{s}", .{hex_str});
    }

    /// Generate a random RGB color (e.g., "rgb(255, 87, 51)")
    pub fn rgb(self: *Color, random: *Random) ![]u8 {
        const r = random.int(0, 255);
        const g = random.int(0, 255);
        const b = random.int(0, 255);

        return std.fmt.allocPrint(self.allocator, "rgb({d}, {d}, {d})", .{ r, g, b });
    }

    /// Generate a random RGBA color (e.g., "rgba(255, 87, 51, 0.8)")
    pub fn rgba(self: *Color, random: *Random) ![]u8 {
        const r = random.int(0, 255);
        const g = random.int(0, 255);
        const b = random.int(0, 255);
        const a = random.float(0.0, 1.0);

        return std.fmt.allocPrint(self.allocator, "rgba({d}, {d}, {d}, {d:.2})", .{ r, g, b, a });
    }

    /// Generate a random HSL color (e.g., "hsl(120, 50%, 50%)")
    pub fn hsl(self: *Color, random: *Random) ![]u8 {
        const h = random.int(0, 360);
        const s = random.int(0, 100);
        const l = random.int(0, 100);

        return std.fmt.allocPrint(self.allocator, "hsl({d}, {d}%, {d}%)", .{ h, s, l });
    }

    /// Generate a random HSLA color (e.g., "hsla(120, 50%, 50%, 0.8)")
    pub fn hsla(self: *Color, random: *Random) ![]u8 {
        const h = random.int(0, 360);
        const s = random.int(0, 100);
        const l = random.int(0, 100);
        const a = random.float(0.0, 1.0);

        return std.fmt.allocPrint(self.allocator, "hsla({d}, {d}%, {d}%, {d:.2})", .{ h, s, l, a });
    }

    /// Generate RGB components as a tuple
    pub fn rgbArray(self: *Color, random: *Random) [3]u8 {
        _ = self;
        return [3]u8{
            @intCast(random.int(0, 255)),
            @intCast(random.int(0, 255)),
            @intCast(random.int(0, 255)),
        };
    }

    /// Generate a random CSS color name
    pub fn cssColor(self: *Color, random: *Random) []const u8 {
        _ = self;
        const css_colors = [_][]const u8{
            "aliceblue",       "antiquewhite",  "aqua",           "aquamarine",
            "azure",           "beige",         "bisque",         "black",
            "blanchedalmond",  "blue",          "blueviolet",     "brown",
            "burlywood",       "cadetblue",     "chartreuse",     "chocolate",
            "coral",           "cornflowerblue", "cornsilk",      "crimson",
            "cyan",            "darkblue",      "darkcyan",       "darkgoldenrod",
            "darkgray",        "darkgreen",     "darkkhaki",      "darkmagenta",
            "darkolivegreen",  "darkorange",    "darkorchid",     "darkred",
            "darksalmon",      "darkseagreen",  "darkslateblue",  "darkslategray",
            "darkturquoise",   "darkviolet",    "deeppink",       "deepskyblue",
            "dimgray",         "dodgerblue",    "firebrick",      "floralwhite",
            "forestgreen",     "fuchsia",       "gainsboro",      "ghostwhite",
            "gold",            "goldenrod",     "gray",           "green",
        };
        return random.arrayElement([]const u8, &css_colors);
    }
};
