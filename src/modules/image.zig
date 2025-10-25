const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Image = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Image {
        return Image{
            .allocator = allocator,
        };
    }

    const categories = [_][]const u8{
        "abstract",   "animals",    "business",   "cats",       "city",
        "food",       "nightlife",  "fashion",    "people",     "nature",
        "sports",     "technics",   "transport",  "travel",     "buildings",
        "art",        "music",      "architecture", "landscape", "portrait",
    };

    const image_types = [_][]const u8{
        "photo",      "illustration", "vector",    "3d-render",  "painting",
        "sketch",     "drawing",      "collage",   "pixel-art",  "animation",
    };

    /// Generate a random image category
    pub fn category(self: *Image, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &categories);
    }

    /// Generate a random image type
    pub fn type_(self: *Image, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &image_types);
    }

    /// Generate a placeholder image URL (using picsum.photos)
    pub fn url(self: *Image, random: *Random, width: u32, height: u32) ![]u8 {
        _ = random;
        return std.fmt.allocPrint(
            self.allocator,
            "https://picsum.photos/{d}/{d}",
            .{ width, height },
        );
    }

    /// Generate a grayscale placeholder image URL
    pub fn grayscaleUrl(self: *Image, random: *Random, width: u32, height: u32) ![]u8 {
        _ = random;
        return std.fmt.allocPrint(
            self.allocator,
            "https://picsum.photos/{d}/{d}?grayscale",
            .{ width, height },
        );
    }

    /// Generate a blurred placeholder image URL
    pub fn blurredUrl(self: *Image, random: *Random, width: u32, height: u32, blur: u8) ![]u8 {
        _ = random;
        return std.fmt.allocPrint(
            self.allocator,
            "https://picsum.photos/{d}/{d}?blur={d}",
            .{ width, height, blur },
        );
    }

    /// Generate random image dimensions
    pub fn dimensions(self: *Image, random: *Random) struct { width: u32, height: u32 } {
        _ = self;
        const common_widths = [_]u32{ 640, 800, 1024, 1280, 1920, 2560, 3840 };
        const common_heights = [_]u32{ 480, 600, 768, 720, 1080, 1440, 2160 };

        return .{
            .width = random.arrayElement(u32, &common_widths),
            .height = random.arrayElement(u32, &common_heights),
        };
    }

    /// Generate a data URI for a 1x1 pixel image
    pub fn dataUri(self: *Image, random: *Random) ![]u8 {
        const colors = [_][]const u8{
            "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7", // Transparent
            "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs=",         // Black
            "R0lGODlhAQABAIAAAP///////yH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==", // White
            "R0lGODlhAQABAIAAAP8AAP///yH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==", // Red
            "R0lGODlhAQABAIAAAAD/AP///yH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==", // Green
            "R0lGODlhAQABAIAAAAAA/////yH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==", // Blue
        };

        const color_data = random.arrayElement([]const u8, &colors);
        return std.fmt.allocPrint(self.allocator, "data:image/gif;base64,{s}", .{color_data});
    }

    /// Generate a random image file name
    pub fn fileName(self: *Image, random: *Random) ![]u8 {
        const extensions = [_][]const u8{ "jpg", "jpeg", "png", "gif", "webp", "svg" };
        const ext = random.arrayElement([]const u8, &extensions);
        const name = try random.replaceSymbols(self.allocator, "image-####");
        defer self.allocator.free(name);
        return std.fmt.allocPrint(self.allocator, "{s}.{s}", .{ name, ext });
    }
};
