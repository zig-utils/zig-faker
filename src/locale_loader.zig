const std = @import("std");
const LocaleDefinition = @import("locale.zig").LocaleDefinition;
const locale_utils = @import("locale_utils.zig");

/// Locale loader with caching and fallback chain support
pub const LocaleLoader = struct {
    allocator: std.mem.Allocator,
    cache: std.StringHashMap(*const LocaleDefinition),

    pub fn init(allocator: std.mem.Allocator) LocaleLoader {
        return LocaleLoader{
            .allocator = allocator,
            .cache = std.StringHashMap(*const LocaleDefinition).init(allocator),
        };
    }

    pub fn deinit(self: *LocaleLoader) void {
        self.cache.deinit();
    }

    /// Load a locale by code, using cache if available
    pub fn load(self: *LocaleLoader, locale_code: []const u8) !*const LocaleDefinition {
        // Check cache first
        if (self.cache.get(locale_code)) |cached| {
            return cached;
        }

        // Try to load the locale
        const locale_def = try self.loadFromSystem(locale_code);

        // Cache it
        const key = try self.allocator.dupe(u8, locale_code);
        try self.cache.put(key, locale_def);

        return locale_def;
    }

    /// Load locale from built-in definitions or fallback chain
    fn loadFromSystem(self: *LocaleLoader, locale_code: []const u8) !*const LocaleDefinition {
        // Parse the locale to understand what's requested
        var info = try locale_utils.parseLocale(self.allocator, locale_code);
        defer info.deinit(self.allocator);

        // Check for exact matches first (regional variants)
        // English variants
        if (std.mem.eql(u8, info.normalized, "en_US")) {
            return &@import("locales/en_US.zig").en_US;
        } else if (std.mem.eql(u8, info.normalized, "en_GB")) {
            return &@import("locales/en_GB.zig").en_GB;
        } else if (std.mem.eql(u8, info.normalized, "en_AU")) {
            return &@import("locales/en_AU.zig").en_AU;
        } else if (std.mem.eql(u8, info.normalized, "en_CA")) {
            return &@import("locales/en_CA.zig").en_CA;
        } else if (std.mem.eql(u8, info.normalized, "en_GH")) {
            return &@import("locales/en_GH.zig").en_GH;
        } else if (std.mem.eql(u8, info.normalized, "en_HK")) {
            return &@import("locales/en_HK.zig").en_HK;
        } else if (std.mem.eql(u8, info.normalized, "en_IE")) {
            return &@import("locales/en_IE.zig").en_IE;
        } else if (std.mem.eql(u8, info.normalized, "en_IN")) {
            return &@import("locales/en_IN.zig").en_IN;
        } else if (std.mem.eql(u8, info.normalized, "en_NG")) {
            return &@import("locales/en_NG.zig").en_NG;
        } else if (std.mem.eql(u8, info.normalized, "en_ZA")) {
            return &@import("locales/en_ZA.zig").en_ZA;
        }
        // Spanish variants
        else if (std.mem.eql(u8, info.normalized, "es_ES")) {
            return &@import("locales/es_ES.zig").es_ES;
        } else if (std.mem.eql(u8, info.normalized, "es_MX")) {
            return &@import("locales/es_MX.zig").es_MX;
        }
        // German variants
        else if (std.mem.eql(u8, info.normalized, "de_DE")) {
            return &@import("locales/de_DE.zig").de_DE;
        } else if (std.mem.eql(u8, info.normalized, "de_AT")) {
            return &@import("locales/de_AT.zig").de_AT;
        } else if (std.mem.eql(u8, info.normalized, "de_CH")) {
            return &@import("locales/de_CH.zig").de_CH;
        }
        // French variants
        else if (std.mem.eql(u8, info.normalized, "fr_FR")) {
            return &@import("locales/fr_FR.zig").fr_FR;
        } else if (std.mem.eql(u8, info.normalized, "fr_CA")) {
            return &@import("locales/fr_CA.zig").fr_CA;
        } else if (std.mem.eql(u8, info.normalized, "fr_BE")) {
            return &@import("locales/fr_BE.zig").fr_BE;
        } else if (std.mem.eql(u8, info.normalized, "fr_CH")) {
            return &@import("locales/fr_CH.zig").fr_CH;
        } else if (std.mem.eql(u8, info.normalized, "fr_LU")) {
            return &@import("locales/fr_LU.zig").fr_LU;
        } else if (std.mem.eql(u8, info.normalized, "fr_SN")) {
            return &@import("locales/fr_SN.zig").fr_SN;
        }
        // Portuguese variants
        else if (std.mem.eql(u8, info.normalized, "pt_BR")) {
            return &@import("locales/pt_BR.zig").pt_BR;
        } else if (std.mem.eql(u8, info.normalized, "pt_PT")) {
            return &@import("locales/pt_PT.zig").pt_PT;
        } else if (std.mem.eql(u8, info.normalized, "pt_MZ")) {
            return &@import("locales/pt_MZ.zig").pt_MZ;
        }
        // Chinese variants
        else if (std.mem.eql(u8, info.normalized, "zh_CN")) {
            return &@import("locales/zh_CN.zig").zh_CN;
        } else if (std.mem.eql(u8, info.normalized, "zh_TW")) {
            return &@import("locales/zh_TW.zig").zh_TW;
        }
        // African variants
        else if (std.mem.eql(u8, info.normalized, "af_ZA")) {
            return &@import("locales/af_ZA.zig").af_ZA;
        } else if (std.mem.eql(u8, info.normalized, "zu_ZA")) {
            return &@import("locales/zu_ZA.zig").zu_ZA;
        }

        // Check base locales
        if (std.mem.eql(u8, info.language, "en")) {
            return &@import("locales/en.zig").en;
        } else if (std.mem.eql(u8, info.language, "es")) {
            return &@import("locales/es.zig").es;
        } else if (std.mem.eql(u8, info.language, "fr")) {
            return &@import("locales/fr.zig").fr;
        } else if (std.mem.eql(u8, info.language, "de")) {
            return &@import("locales/de.zig").de;
        } else if (std.mem.eql(u8, info.language, "pt")) {
            return &@import("locales/pt.zig").pt;
        } else if (std.mem.eql(u8, info.language, "it")) {
            return &@import("locales/it.zig").it;
        } else if (std.mem.eql(u8, info.language, "nl")) {
            return &@import("locales/nl.zig").nl;
        } else if (std.mem.eql(u8, info.language, "ja")) {
            return &@import("locales/ja.zig").ja;
        } else if (std.mem.eql(u8, info.language, "zh")) {
            return &@import("locales/zh.zig").zh;
        } else if (std.mem.eql(u8, info.language, "ko")) {
            return &@import("locales/ko.zig").ko;
        } else if (std.mem.eql(u8, info.language, "uk")) {
            return &@import("locales/uk.zig").uk;
        } else if (std.mem.eql(u8, info.language, "pl")) {
            return &@import("locales/pl.zig").pl;
        } else if (std.mem.eql(u8, info.language, "sv")) {
            return &@import("locales/sv.zig").sv;
        } else if (std.mem.eql(u8, info.language, "no")) {
            return &@import("locales/no.zig").no;
        } else if (std.mem.eql(u8, info.language, "da")) {
            return &@import("locales/da.zig").da;
        } else if (std.mem.eql(u8, info.language, "fi")) {
            return &@import("locales/fi.zig").fi;
        } else if (std.mem.eql(u8, info.language, "cs")) {
            return &@import("locales/cs.zig").cs;
        } else if (std.mem.eql(u8, info.language, "tr")) {
            return &@import("locales/tr.zig").tr;
        } else if (std.mem.eql(u8, info.language, "ar")) {
            return &@import("locales/ar.zig").ar;
        } else if (std.mem.eql(u8, info.language, "he")) {
            return &@import("locales/he.zig").he;
        } else if (std.mem.eql(u8, info.language, "hi")) {
            return &@import("locales/hi.zig").hi;
        } else if (std.mem.eql(u8, info.language, "af")) {
            return &@import("locales/af.zig").af;
        } else if (std.mem.eql(u8, info.language, "zu")) {
            return &@import("locales/zu.zig").zu;
        } else if (std.mem.eql(u8, info.language, "az")) {
            return &@import("locales/az.zig").az;
        } else if (std.mem.eql(u8, info.language, "eo")) {
            return &@import("locales/eo.zig").eo;
        } else if (std.mem.eql(u8, info.language, "fa")) {
            return &@import("locales/fa.zig").fa;
        } else if (std.mem.eql(u8, info.language, "tl")) {
            return &@import("locales/tl.zig").tl;
        }

        // Fallback to English
        std.debug.print("Warning: Locale '{s}' not found, falling back to 'en'\n", .{locale_code});
        return &@import("locales/en.zig").en;
    }

    /// Load a locale with fallback chain
    /// Tries each locale in the fallback chain until one is found
    pub fn loadWithFallback(self: *LocaleLoader, locale_code: []const u8) !*const LocaleDefinition {
        const chain = try locale_utils.getLocaleFallbackChain(self.allocator, locale_code);
        defer locale_utils.freeLocaleFallbackChain(self.allocator, chain);

        // Try each locale in the chain
        for (chain) |fallback_code| {
            if (self.load(fallback_code)) |locale_def| {
                return locale_def;
            } else |_| {
                continue;
            }
        }

        // If all fail, return English as ultimate fallback
        return self.load("en");
    }

    /// Check if a locale is cached
    pub fn isCached(self: *LocaleLoader, locale_code: []const u8) bool {
        return self.cache.contains(locale_code);
    }

    /// Clear the cache
    pub fn clearCache(self: *LocaleLoader) void {
        var iter = self.cache.iterator();
        while (iter.next()) |entry| {
            self.allocator.free(entry.key_ptr.*);
        }
        self.cache.clearRetainingCapacity();
    }

    /// Get number of cached locales
    pub fn getCacheSize(self: *LocaleLoader) usize {
        return self.cache.count();
    }
};

/// Global locale loader instance (optional convenience)
var global_loader: ?LocaleLoader = null;
var global_loader_mutex = std.Thread.Mutex{};

/// Get or initialize the global locale loader
pub fn getGlobalLoader(allocator: std.mem.Allocator) *LocaleLoader {
    global_loader_mutex.lock();
    defer global_loader_mutex.unlock();

    if (global_loader == null) {
        global_loader = LocaleLoader.init(allocator);
    }

    return &global_loader.?;
}

/// Clean up the global locale loader
pub fn deinitGlobalLoader() void {
    global_loader_mutex.lock();
    defer global_loader_mutex.unlock();

    if (global_loader) |*loader| {
        loader.deinit();
        global_loader = null;
    }
}

// ==================== Tests ====================

test "locale loader basic" {
    const allocator = std.testing.allocator;

    var loader = LocaleLoader.init(allocator);
    defer loader.deinit();

    const locale = try loader.load("en");
    try std.testing.expectEqualStrings("English", locale.title);
}

test "locale loader caching" {
    const allocator = std.testing.allocator;

    var loader = LocaleLoader.init(allocator);
    defer loader.deinit();

    try std.testing.expect(!loader.isCached("en"));

    _ = try loader.load("en");

    try std.testing.expect(loader.isCached("en"));
    try std.testing.expectEqual(@as(usize, 1), loader.getCacheSize());
}

test "locale loader fallback chain" {
    const allocator = std.testing.allocator;

    var loader = LocaleLoader.init(allocator);
    defer loader.deinit();

    // Loading en_US should load en_US directly
    const locale = try loader.loadWithFallback("en_US");
    try std.testing.expectEqualStrings("English (United States)", locale.title);
}

test "locale loader unknown locale" {
    const allocator = std.testing.allocator;

    var loader = LocaleLoader.init(allocator);
    defer loader.deinit();

    // Loading unknown locale should fallback to en
    const locale = try loader.loadWithFallback("xx_YY");
    try std.testing.expectEqualStrings("English", locale.title);
}
