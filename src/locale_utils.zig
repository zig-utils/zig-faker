const std = @import("std");
const LocaleDefinition = @import("locale.zig").LocaleDefinition;

/// Information about a parsed locale code
pub const LocaleInfo = struct {
    /// Full locale code as provided (e.g., "en_US", "es-MX")
    full: []const u8,
    /// Language code (e.g., "en", "es")
    language: []const u8,
    /// Region code (e.g., "US", "MX") - null if no region
    region: ?[]const u8,
    /// Normalized locale code with underscore (e.g., "en_US", "es_MX")
    normalized: []const u8,

    pub fn deinit(self: *LocaleInfo, allocator: std.mem.Allocator) void {
        allocator.free(self.language);
        if (self.region) |r| {
            allocator.free(r);
        }
        allocator.free(self.normalized);
    }
};

/// Parse a locale code into its components
/// Supports both underscore (en_US) and hyphen (en-US) formats
///
/// Examples:
///   parseLocale("en_US") -> { language: "en", region: "US", normalized: "en_US" }
///   parseLocale("en-GB") -> { language: "en", region: "GB", normalized: "en_GB" }
///   parseLocale("es")    -> { language: "es", region: null, normalized: "es" }
pub fn parseLocale(allocator: std.mem.Allocator, locale: []const u8) !LocaleInfo {
    // Find separator (either - or _)
    var separator_pos: ?usize = null;
    for (locale, 0..) |c, i| {
        if (c == '-' or c == '_') {
            separator_pos = i;
            break;
        }
    }

    if (separator_pos) |pos| {
        // Has region code
        const language = try allocator.dupe(u8, locale[0..pos]);
        errdefer allocator.free(language);

        const region_str = try allocator.dupe(u8, locale[pos + 1..]);
        errdefer allocator.free(region_str);

        // Lowercase language, uppercase region
        for (language) |*c| {
            c.* = std.ascii.toLower(c.*);
        }
        for (region_str) |*c| {
            c.* = std.ascii.toUpper(c.*);
        }

        // Create normalized version with underscore
        const normalized = try std.fmt.allocPrint(allocator, "{s}_{s}", .{language, region_str});

        return LocaleInfo{
            .full = locale,
            .language = language,
            .region = region_str,
            .normalized = normalized,
        };
    } else {
        // No region code, just language
        const language = try allocator.dupe(u8, locale);
        errdefer allocator.free(language);

        // Lowercase language
        for (language) |*c| {
            c.* = std.ascii.toLower(c.*);
        }

        const normalized = try allocator.dupe(u8, language);

        return LocaleInfo{
            .full = locale,
            .language = language,
            .region = null,
            .normalized = normalized,
        };
    }
}

/// Get the fallback chain for a locale
/// Returns array of locale codes to try in order
///
/// Examples:
///   getLocaleFallbackChain("en_US") -> ["en_US", "en"]
///   getLocaleFallbackChain("es_MX") -> ["es_MX", "es"]
///   getLocaleFallbackChain("en")    -> ["en"]
pub fn getLocaleFallbackChain(allocator: std.mem.Allocator, locale: []const u8) ![][]const u8 {
    var info = try parseLocale(allocator, locale);
    defer info.deinit(allocator);

    if (info.region != null) {
        // Has region - return [normalized, language]
        var chain = try allocator.alloc([]const u8, 2);
        chain[0] = try allocator.dupe(u8, info.normalized);
        chain[1] = try allocator.dupe(u8, info.language);
        return chain;
    } else {
        // No region - return [language]
        var chain = try allocator.alloc([]const u8, 1);
        chain[0] = try allocator.dupe(u8, info.language);
        return chain;
    }
}

/// Free memory allocated by getLocaleFallbackChain
pub fn freeLocaleFallbackChain(allocator: std.mem.Allocator, chain: [][]const u8) void {
    for (chain) |item| {
        allocator.free(item);
    }
    allocator.free(chain);
}

/// Detect system locale from environment variables
/// Checks in order: LANG, LC_ALL, LC_MESSAGES, LANGUAGE
/// Returns "en" as fallback if none found
pub fn detectSystemLocale(allocator: std.mem.Allocator) ![]const u8 {
    // Try environment variables in order
    const env_vars = [_][]const u8{ "LANG", "LC_ALL", "LC_MESSAGES", "LANGUAGE" };

    for (env_vars) |env_var| {
        if (std.process.getEnvVarOwned(allocator, env_var)) |full_locale| {
            defer allocator.free(full_locale);

            // Parse locale (e.g., "en_US.UTF-8" -> "en_US")
            // Remove encoding suffix if present
            var locale_str = full_locale;
            if (std.mem.indexOf(u8, full_locale, ".")) |dot_pos| {
                locale_str = full_locale[0..dot_pos];
            }

            // Return the locale code (without encoding)
            return try allocator.dupe(u8, locale_str);
        } else |_| {
            continue;
        }
    }

    // Fallback to English
    return try allocator.dupe(u8, "en");
}

/// Merge two locale definitions
/// Variant takes precedence over base for any defined fields
pub fn mergeLocaleDefinitions(
    allocator: std.mem.Allocator,
    base: *const LocaleDefinition,
    variant: *const LocaleDefinition,
) !LocaleDefinition {
    _ = allocator; // Reserved for future use if deep copying needed

    // For now, we do a shallow merge where variant overrides base
    // In a real implementation, you'd want to deep merge the nested structures
    return LocaleDefinition{
        .title = if (variant.title.len > 0) variant.title else base.title,
        .person = if (variant.person.first_name_male.len > 0) variant.person else base.person,
        .address = if (variant.address.city.len > 0) variant.address else base.address,
        .company = if (variant.company.name.len > 0) variant.company else base.company,
        .internet = if (variant.internet.domain_suffix.len > 0) variant.internet else base.internet,
        .phone = if (variant.phone.format.len > 0) variant.phone else base.phone,
        .food = if (variant.food.dish.len > 0) variant.food else base.food,
        .animal = if (variant.animal.dog.len > 0) variant.animal else base.animal,
    };
}

// ==================== Available Locales ====================

/// Base locales available (excluding Russian per requirements)
pub const AVAILABLE_BASE_LOCALES = [_][]const u8{
    "af", // Afrikaans
    "ar", // Arabic
    "az", // Azerbaijani
    "cs", // Czech
    "da", // Danish
    "de", // German
    "en", // English
    "eo", // Esperanto
    "es", // Spanish
    "fa", // Persian
    "fi", // Finnish
    "fr", // French
    "he", // Hebrew
    "hi", // Hindi
    "it", // Italian
    "ja", // Japanese
    "ko", // Korean
    "nl", // Dutch
    "no", // Norwegian
    "pl", // Polish
    "pt", // Portuguese
    "sv", // Swedish
    "tl", // Tagalog
    "tr", // Turkish
    "uk", // Ukrainian
    "zh", // Chinese
    "zu", // Zulu
};

/// Available locale variants (region-specific)
pub const AVAILABLE_LOCALE_VARIANTS = [_][]const u8{
    "af_ZA", // Afrikaans (South Africa)
    "de_AT", // German (Austria)
    "de_CH", // German (Switzerland)
    "de_DE", // German (Germany)
    "en_AU", // English (Australia)
    "en_CA", // English (Canada)
    "en_GB", // English (United Kingdom)
    "en_GH", // English (Ghana)
    "en_HK", // English (Hong Kong)
    "en_IE", // English (Ireland)
    "en_IN", // English (India)
    "en_NG", // English (Nigeria)
    "en_US", // English (United States)
    "en_ZA", // English (South Africa)
    "es_ES", // Spanish (Spain)
    "es_MX", // Spanish (Mexico)
    "fr_BE", // French (Belgium)
    "fr_CA", // French (Canada)
    "fr_CH", // French (Switzerland)
    "fr_FR", // French (France)
    "fr_LU", // French (Luxembourg)
    "fr_SN", // French (Senegal)
    "pt_BR", // Portuguese (Brazil)
    "pt_MZ", // Portuguese (Mozambique)
    "pt_PT", // Portuguese (Portugal)
    "zh_CN", // Chinese (China)
    "zh_TW", // Chinese (Taiwan)
    "zu_ZA", // Zulu (South Africa)
};

/// Check if a locale code is a supported base locale
pub fn isBaseLocale(locale: []const u8) bool {
    for (AVAILABLE_BASE_LOCALES) |available| {
        if (std.mem.eql(u8, locale, available)) {
            return true;
        }
    }
    return false;
}

/// Check if a locale code is a supported locale variant
pub fn isLocaleVariant(locale: []const u8) bool {
    for (AVAILABLE_LOCALE_VARIANTS) |available| {
        if (std.mem.eql(u8, locale, available)) {
            return true;
        }
    }
    return false;
}

/// Check if a locale is available (base or variant)
pub fn isLocaleAvailable(locale: []const u8) bool {
    return isBaseLocale(locale) or isLocaleVariant(locale);
}

// ==================== Tests ====================

test "parse locale with region" {
    const allocator = std.testing.allocator;

    var info = try parseLocale(allocator, "en_US");
    defer info.deinit(allocator);

    try std.testing.expectEqualStrings("en", info.language);
    try std.testing.expect(info.region != null);
    try std.testing.expectEqualStrings("US", info.region.?);
    try std.testing.expectEqualStrings("en_US", info.normalized);
}

test "parse locale with hyphen" {
    const allocator = std.testing.allocator;

    var info = try parseLocale(allocator, "es-MX");
    defer info.deinit(allocator);

    try std.testing.expectEqualStrings("es", info.language);
    try std.testing.expect(info.region != null);
    try std.testing.expectEqualStrings("MX", info.region.?);
    try std.testing.expectEqualStrings("es_MX", info.normalized);
}

test "parse locale without region" {
    const allocator = std.testing.allocator;

    var info = try parseLocale(allocator, "fr");
    defer info.deinit(allocator);

    try std.testing.expectEqualStrings("fr", info.language);
    try std.testing.expect(info.region == null);
    try std.testing.expectEqualStrings("fr", info.normalized);
}

test "fallback chain with region" {
    const allocator = std.testing.allocator;

    const chain = try getLocaleFallbackChain(allocator, "en_GB");
    defer freeLocaleFallbackChain(allocator, chain);

    try std.testing.expectEqual(@as(usize, 2), chain.len);
    try std.testing.expectEqualStrings("en_GB", chain[0]);
    try std.testing.expectEqualStrings("en", chain[1]);
}

test "fallback chain without region" {
    const allocator = std.testing.allocator;

    const chain = try getLocaleFallbackChain(allocator, "es");
    defer freeLocaleFallbackChain(allocator, chain);

    try std.testing.expectEqual(@as(usize, 1), chain.len);
    try std.testing.expectEqualStrings("es", chain[0]);
}

test "check available locales" {
    try std.testing.expect(isBaseLocale("en"));
    try std.testing.expect(isBaseLocale("es"));
    try std.testing.expect(!isBaseLocale("en_US"));

    try std.testing.expect(isLocaleVariant("en_US"));
    try std.testing.expect(isLocaleVariant("es_MX"));
    try std.testing.expect(!isLocaleVariant("en"));

    try std.testing.expect(isLocaleAvailable("en"));
    try std.testing.expect(isLocaleAvailable("en_US"));
    try std.testing.expect(!isLocaleAvailable("xx"));
}
