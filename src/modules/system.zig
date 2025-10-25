const std = @import("std");
const Random = @import("../random.zig").Random;

pub const System = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) System {
        return System{
            .allocator = allocator,
        };
    }

    const file_names = [_][]const u8{
        "document",  "report",    "presentation", "spreadsheet", "image",
        "video",     "audio",     "archive",      "database",    "config",
        "log",       "backup",    "temp",         "cache",       "data",
        "index",     "readme",    "license",      "manifest",    "package",
    };

    const file_extensions = [_][]const u8{
        // Documents
        "txt",  "doc",  "docx", "pdf",  "rtf",  "odt",  "md",   "tex",
        // Spreadsheets
        "xls",  "xlsx", "csv",  "ods",
        // Presentations
        "ppt",  "pptx", "key",  "odp",
        // Images
        "jpg",  "jpeg", "png",  "gif",  "bmp",  "svg",  "ico",  "webp",
        // Videos
        "mp4",  "avi",  "mov",  "wmv",  "flv",  "mkv",  "webm",
        // Audio
        "mp3",  "wav",  "flac", "aac",  "ogg",  "wma",  "m4a",
        // Archives
        "zip",  "rar",  "7z",   "tar",  "gz",   "bz2",  "xz",
        // Code
        "c",    "cpp",  "h",    "java", "py",   "js",   "ts",   "go",
        "rs",   "rb",   "php",  "swift", "kt",  "cs",   "vb",   "sh",
        // Data
        "json", "xml",  "yaml", "yml",  "toml", "ini",  "cfg",
        // Database
        "db",   "sql",  "sqlite", "mdb",
        // Other
        "html", "css",  "scss", "less", "exe",  "dll",  "so",   "dylib",
    };

    const mime_types = [_][]const u8{
        // Text
        "text/plain",                "text/html",               "text/css",
        "text/javascript",           "text/csv",                "text/xml",
        // Application
        "application/json",          "application/pdf",         "application/zip",
        "application/x-tar",         "application/gzip",        "application/xml",
        "application/octet-stream",  "application/javascript",
        // Image
        "image/jpeg",               "image/png",                "image/gif",
        "image/svg+xml",            "image/webp",               "image/bmp",
        // Video
        "video/mp4",                "video/mpeg",               "video/webm",
        "video/quicktime",          "video/x-msvideo",
        // Audio
        "audio/mpeg",               "audio/wav",                "audio/webm",
        "audio/ogg",                "audio/aac",
    };

    const directory_paths = [_][]const u8{
        "/home",     "/usr",      "/var",      "/tmp",      "/opt",
        "/etc",      "/bin",      "/sbin",     "/lib",      "/root",
        "/boot",     "/dev",      "/proc",     "/sys",      "/mnt",
        "/media",    "/srv",      "/run",
    };

    /// Generate a random file name
    pub fn fileName(self: *System, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &file_names);
    }

    /// Generate a random file extension
    pub fn fileExt(self: *System, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &file_extensions);
    }

    /// Generate a complete file name with extension
    pub fn filePath(self: *System, random: *Random) ![]u8 {
        const name = self.fileName(random);
        const ext = self.fileExt(random);
        return std.fmt.allocPrint(self.allocator, "{s}.{s}", .{ name, ext });
    }

    /// Generate a random MIME type
    pub fn mimeType(self: *System, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &mime_types);
    }

    /// Generate a random directory path
    pub fn directoryPath(self: *System, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &directory_paths);
    }

    /// Generate a full file path
    pub fn fullPath(self: *System, random: *Random) ![]u8 {
        const dir = self.directoryPath(random);
        const file = try self.filePath(random);
        defer self.allocator.free(file);
        return std.fmt.allocPrint(self.allocator, "{s}/{s}", .{ dir, file });
    }

    /// Generate a semantic version
    pub fn semver(self: *System, random: *Random) ![]u8 {
        const major = random.int(0, 9);
        const minor = random.int(0, 99);
        const patch = random.int(0, 99);
        return std.fmt.allocPrint(self.allocator, "{d}.{d}.{d}", .{ major, minor, patch });
    }
};
