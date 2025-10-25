const std = @import("std");

/// Validation mode determines how strict validation should be
pub const ValidationMode = enum {
    /// Strict mode: All validation rules must pass
    strict,
    /// Non-strict mode: Warnings are logged but validation passes
    non_strict,
};

/// Validation result
pub const ValidationResult = struct {
    valid: bool,
    errors: []const []const u8,
    warnings: []const []const u8,

    pub fn deinit(self: *ValidationResult, allocator: std.mem.Allocator) void {
        for (self.errors) |err| {
            allocator.free(err);
        }
        allocator.free(self.errors);

        for (self.warnings) |warn| {
            allocator.free(warn);
        }
        allocator.free(self.warnings);
    }
};

/// Custom validator function type
pub const ValidatorFn = *const fn (value: []const u8) bool;

/// Validation rule
pub const ValidationRule = struct {
    name: []const u8,
    validator: ValidatorFn,
    error_message: []const u8,
};

/// Main validation module
pub const Validation = struct {
    allocator: std.mem.Allocator,
    mode: ValidationMode,

    pub fn init(allocator: std.mem.Allocator, mode: ValidationMode) Validation {
        return Validation{
            .allocator = allocator,
            .mode = mode,
        };
    }

    // ==================== Built-in Validators ====================

    /// Validate email address format
    pub fn validateEmail(value: []const u8) bool {
        if (value.len == 0) return false;

        // Must contain exactly one @
        var at_count: usize = 0;
        var at_pos: ?usize = null;
        for (value, 0..) |c, i| {
            if (c == '@') {
                at_count += 1;
                at_pos = i;
            }
        }
        if (at_count != 1 or at_pos == null) return false;

        const pos = at_pos.?;

        // Must have characters before @
        if (pos == 0) return false;

        // Must have domain after @
        if (pos >= value.len - 1) return false;

        const domain = value[pos + 1..];

        // Domain must contain at least one dot
        var has_dot = false;
        for (domain) |c| {
            if (c == '.') {
                has_dot = true;
                break;
            }
        }
        if (!has_dot) return false;

        // Domain must not start or end with dot
        if (domain[0] == '.' or domain[domain.len - 1] == '.') return false;

        return true;
    }

    /// Validate URL format
    pub fn validateUrl(value: []const u8) bool {
        if (value.len < 8) return false; // Minimum: http://a

        // Must start with http:// or https://
        if (std.mem.startsWith(u8, value, "http://") or
            std.mem.startsWith(u8, value, "https://")) {

            const start = if (std.mem.startsWith(u8, value, "https://"))
                @as(usize, 8) else @as(usize, 7);

            // Must have content after protocol
            if (start >= value.len) return false;

            const domain = value[start..];

            // Domain must have at least one character
            if (domain.len == 0) return false;

            return true;
        }

        return false;
    }

    /// Validate phone number (US format)
    pub fn validatePhone(value: []const u8) bool {
        if (value.len == 0) return false;

        var digit_count: usize = 0;
        for (value) |c| {
            if (std.ascii.isDigit(c)) {
                digit_count += 1;
            } else if (c != '-' and c != '(' and c != ')' and c != ' ' and c != '+') {
                return false; // Invalid character
            }
        }

        // US phone numbers have 10 digits (without country code)
        // or 11 digits (with country code)
        return digit_count == 10 or digit_count == 11;
    }

    /// Validate UUID format
    pub fn validateUuid(value: []const u8) bool {
        // UUID format: 8-4-4-4-12 (36 characters with hyphens)
        if (value.len != 36) return false;

        // Check hyphen positions
        if (value[8] != '-' or value[13] != '-' or
            value[18] != '-' or value[23] != '-') {
            return false;
        }

        // Check all other characters are hex
        const hex_positions = [_][]const usize{
            &[_]usize{0, 1, 2, 3, 4, 5, 6, 7},
            &[_]usize{9, 10, 11, 12},
            &[_]usize{14, 15, 16, 17},
            &[_]usize{19, 20, 21, 22},
            &[_]usize{24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35},
        };

        for (hex_positions) |positions| {
            for (positions) |pos| {
                if (!std.ascii.isHex(value[pos])) {
                    return false;
                }
            }
        }

        return true;
    }

    /// Validate hexadecimal color format (#RGB or #RRGGBB)
    pub fn validateHexColor(value: []const u8) bool {
        if (value.len == 0) return false;
        if (value[0] != '#') return false;

        const hex_part = value[1..];

        // Must be either 3 or 6 characters
        if (hex_part.len != 3 and hex_part.len != 6) return false;

        // All characters must be hex
        for (hex_part) |c| {
            if (!std.ascii.isHex(c)) return false;
        }

        return true;
    }

    /// Validate credit card number using Luhn algorithm
    pub fn validateCreditCard(value: []const u8) bool {
        if (value.len == 0) return false;

        const allocator = std.heap.page_allocator;
        var digits = std.ArrayList(u8).initCapacity(allocator, 20) catch return false;
        defer digits.deinit(allocator);

        // Extract only digits
        for (value) |c| {
            if (std.ascii.isDigit(c)) {
                digits.append(allocator, c - '0') catch return false;
            } else if (c != '-' and c != ' ') {
                return false; // Invalid character
            }
        }

        const digit_slice = digits.items;
        if (digit_slice.len < 13 or digit_slice.len > 19) return false;

        // Luhn algorithm
        var sum: u32 = 0;
        var alternate = false;

        var i: usize = digit_slice.len;
        while (i > 0) {
            i -= 1;
            var digit = digit_slice[i];

            if (alternate) {
                digit *= 2;
                if (digit > 9) {
                    digit -= 9;
                }
            }

            sum += digit;
            alternate = !alternate;
        }

        return (sum % 10) == 0;
    }

    /// Validate IPv4 address
    pub fn validateIpv4(value: []const u8) bool {
        var octets = std.mem.splitSequence(u8, value, ".");
        var count: usize = 0;

        while (octets.next()) |octet| {
            count += 1;
            if (count > 4) return false;

            // Parse octet as number
            const num = std.fmt.parseInt(u16, octet, 10) catch return false;

            // Must be 0-255
            if (num > 255) return false;
        }

        return count == 4;
    }

    /// Validate IPv6 address (simplified check)
    pub fn validateIpv6(value: []const u8) bool {
        if (value.len < 2) return false;

        var colon_count: usize = 0;
        var has_double_colon = false;

        var i: usize = 0;
        while (i < value.len) : (i += 1) {
            const c = value[i];

            if (c == ':') {
                colon_count += 1;
                // Check for ::
                if (i + 1 < value.len and value[i + 1] == ':') {
                    has_double_colon = true;
                }
            } else if (!std.ascii.isHex(c)) {
                return false;
            }
        }

        // IPv6 should have 7 colons or fewer with ::
        if (has_double_colon) {
            return colon_count >= 2 and colon_count <= 7;
        } else {
            return colon_count == 7;
        }
    }

    /// Validate that string is not empty
    pub fn validateNotEmpty(value: []const u8) bool {
        return value.len > 0;
    }

    /// Validate minimum length
    pub fn validateMinLength(value: []const u8, min_length: usize) bool {
        return value.len >= min_length;
    }

    /// Validate maximum length
    pub fn validateMaxLength(value: []const u8, max_length: usize) bool {
        return value.len <= max_length;
    }

    /// Validate exact length
    pub fn validateLength(value: []const u8, exact_length: usize) bool {
        return value.len == exact_length;
    }

    /// Validate that string contains only alphanumeric characters
    pub fn validateAlphanumeric(value: []const u8) bool {
        if (value.len == 0) return false;

        for (value) |c| {
            if (!std.ascii.isAlphanumeric(c)) return false;
        }

        return true;
    }

    /// Validate that string contains only alphabetic characters
    pub fn validateAlphabetic(value: []const u8) bool {
        if (value.len == 0) return false;

        for (value) |c| {
            if (!std.ascii.isAlphabetic(c)) return false;
        }

        return true;
    }

    /// Validate that string contains only numeric characters
    pub fn validateNumeric(value: []const u8) bool {
        if (value.len == 0) return false;

        for (value) |c| {
            if (!std.ascii.isDigit(c)) return false;
        }

        return true;
    }

    /// Validate that value matches a pattern (simple wildcard matching)
    pub fn validatePattern(value: []const u8, pattern: []const u8) bool {
        // Simple pattern matching with * as wildcard
        if (std.mem.indexOf(u8, pattern, "*")) |_| {
            // Has wildcard - do simple prefix/suffix matching
            if (std.mem.startsWith(u8, pattern, "*")) {
                const suffix = pattern[1..];
                return std.mem.endsWith(u8, value, suffix);
            } else if (std.mem.endsWith(u8, pattern, "*")) {
                const prefix = pattern[0..pattern.len - 1];
                return std.mem.startsWith(u8, value, prefix);
            }
            // TODO: More complex wildcard matching
            return true;
        } else {
            // No wildcard - exact match
            return std.mem.eql(u8, value, pattern);
        }
    }

    // ==================== Validation Engine ====================

    /// Validate a value against multiple rules
    pub fn validateWithRules(
        self: *Validation,
        value: []const u8,
        rules: []const ValidationRule,
    ) !ValidationResult {
        var errors = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer errors.deinit(self.allocator);
        var warnings = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer warnings.deinit(self.allocator);

        for (rules) |rule| {
            if (!rule.validator(value)) {
                const error_msg = try std.fmt.allocPrint(
                    self.allocator,
                    "{s}: {s}",
                    .{rule.name, rule.error_message}
                );

                switch (self.mode) {
                    .strict => try errors.append(self.allocator, error_msg),
                    .non_strict => try warnings.append(self.allocator, error_msg),
                }
            }
        }

        const valid = errors.items.len == 0;

        return ValidationResult{
            .valid = valid,
            .errors = try errors.toOwnedSlice(self.allocator),
            .warnings = try warnings.toOwnedSlice(self.allocator),
        };
    }

    /// Validate using a custom validator function
    pub fn validateCustom(
        self: *Validation,
        value: []const u8,
        validator: ValidatorFn,
        error_message: []const u8,
    ) !ValidationResult {
        const valid = validator(value);

        var errors = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer errors.deinit(self.allocator);
        var warnings = std.ArrayList([]const u8).initCapacity(self.allocator, 4) catch unreachable;
        defer warnings.deinit(self.allocator);

        if (!valid) {
            const error_msg = try self.allocator.dupe(u8, error_message);

            switch (self.mode) {
                .strict => try errors.append(self.allocator, error_msg),
                .non_strict => try warnings.append(self.allocator, error_msg),
            }
        }

        return ValidationResult{
            .valid = valid or self.mode == .non_strict,
            .errors = try errors.toOwnedSlice(self.allocator),
            .warnings = try warnings.toOwnedSlice(self.allocator),
        };
    }

    /// Quick validation helper for single validator
    pub fn validate(
        _: *Validation,
        value: []const u8,
        validator_type: ValidatorType,
    ) bool {
        return switch (validator_type) {
            .email => validateEmail(value),
            .url => validateUrl(value),
            .phone => validatePhone(value),
            .uuid => validateUuid(value),
            .hex_color => validateHexColor(value),
            .credit_card => validateCreditCard(value),
            .ipv4 => validateIpv4(value),
            .ipv6 => validateIpv6(value),
            .not_empty => validateNotEmpty(value),
            .alphanumeric => validateAlphanumeric(value),
            .alphabetic => validateAlphabetic(value),
            .numeric => validateNumeric(value),
        };
    }
};

/// Built-in validator types
pub const ValidatorType = enum {
    email,
    url,
    phone,
    uuid,
    hex_color,
    credit_card,
    ipv4,
    ipv6,
    not_empty,
    alphanumeric,
    alphabetic,
    numeric,
};

// ==================== Tests ====================

test "validate email" {
    try std.testing.expect(Validation.validateEmail("test@example.com"));
    try std.testing.expect(Validation.validateEmail("user.name@domain.co.uk"));
    try std.testing.expect(!Validation.validateEmail("invalid"));
    try std.testing.expect(!Validation.validateEmail("@example.com"));
    try std.testing.expect(!Validation.validateEmail("test@"));
    try std.testing.expect(!Validation.validateEmail("test@@example.com"));
}

test "validate URL" {
    try std.testing.expect(Validation.validateUrl("http://example.com"));
    try std.testing.expect(Validation.validateUrl("https://example.com"));
    try std.testing.expect(Validation.validateUrl("https://sub.example.com/path"));
    try std.testing.expect(!Validation.validateUrl("ftp://example.com"));
    try std.testing.expect(!Validation.validateUrl("example.com"));
    try std.testing.expect(!Validation.validateUrl("http://"));
}

test "validate phone" {
    try std.testing.expect(Validation.validatePhone("123-456-7890"));
    try std.testing.expect(Validation.validatePhone("(123) 456-7890"));
    try std.testing.expect(Validation.validatePhone("1234567890"));
    try std.testing.expect(Validation.validatePhone("+11234567890"));
    try std.testing.expect(!Validation.validatePhone("12345"));
    try std.testing.expect(!Validation.validatePhone("abc-def-ghij"));
}

test "validate UUID" {
    try std.testing.expect(Validation.validateUuid("550e8400-e29b-41d4-a716-446655440000"));
    try std.testing.expect(!Validation.validateUuid("550e8400-e29b-41d4-a716"));
    try std.testing.expect(!Validation.validateUuid("invalid-uuid"));
}

test "validate hex color" {
    try std.testing.expect(Validation.validateHexColor("#fff"));
    try std.testing.expect(Validation.validateHexColor("#ffffff"));
    try std.testing.expect(Validation.validateHexColor("#FF5733"));
    try std.testing.expect(!Validation.validateHexColor("ffffff"));
    try std.testing.expect(!Validation.validateHexColor("#ff"));
    try std.testing.expect(!Validation.validateHexColor("#gggggg"));
}

test "validate credit card" {
    // Valid test cards (using Luhn algorithm)
    try std.testing.expect(Validation.validateCreditCard("4532015112830366")); // Visa
    try std.testing.expect(Validation.validateCreditCard("6011-1111-1111-1117")); // Discover
    try std.testing.expect(!Validation.validateCreditCard("1234-5678-9012-3456")); // Invalid
}

test "validate IPv4" {
    try std.testing.expect(Validation.validateIpv4("192.168.1.1"));
    try std.testing.expect(Validation.validateIpv4("10.0.0.1"));
    try std.testing.expect(!Validation.validateIpv4("256.1.1.1"));
    try std.testing.expect(!Validation.validateIpv4("192.168.1"));
    try std.testing.expect(!Validation.validateIpv4("192.168.1.1.1"));
}

test "validate string types" {
    try std.testing.expect(Validation.validateAlphanumeric("abc123"));
    try std.testing.expect(!Validation.validateAlphanumeric("abc-123"));

    try std.testing.expect(Validation.validateAlphabetic("abcXYZ"));
    try std.testing.expect(!Validation.validateAlphabetic("abc123"));

    try std.testing.expect(Validation.validateNumeric("12345"));
    try std.testing.expect(!Validation.validateNumeric("123abc"));
}

test "validate length" {
    try std.testing.expect(Validation.validateMinLength("hello", 3));
    try std.testing.expect(!Validation.validateMinLength("hi", 3));

    try std.testing.expect(Validation.validateMaxLength("hello", 10));
    try std.testing.expect(!Validation.validateMaxLength("hello world", 10));

    try std.testing.expect(Validation.validateLength("hello", 5));
    try std.testing.expect(!Validation.validateLength("hello", 10));
}

test "validation with rules - strict mode" {
    const allocator = std.testing.allocator;
    var validator = Validation.init(allocator, .strict);

    const rules = [_]ValidationRule{
        .{
            .name = "email_format",
            .validator = Validation.validateEmail,
            .error_message = "Invalid email format",
        },
    };

    var result = try validator.validateWithRules("test@example.com", &rules);
    defer result.deinit(allocator);

    try std.testing.expect(result.valid);
    try std.testing.expectEqual(@as(usize, 0), result.errors.len);
}

test "validation with rules - non-strict mode" {
    const allocator = std.testing.allocator;
    var validator = Validation.init(allocator, .non_strict);

    const rules = [_]ValidationRule{
        .{
            .name = "email_format",
            .validator = Validation.validateEmail,
            .error_message = "Invalid email format",
        },
    };

    var result = try validator.validateWithRules("invalid-email", &rules);
    defer result.deinit(allocator);

    // Non-strict mode should pass with warnings
    try std.testing.expect(result.valid);
    try std.testing.expectEqual(@as(usize, 0), result.errors.len);
    try std.testing.expectEqual(@as(usize, 1), result.warnings.len);
}
