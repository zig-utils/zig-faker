const std = @import("std");

// Core modules
pub const Random = @import("random.zig").Random;
pub const locale = @import("locale.zig");
pub const LocaleDefinition = locale.LocaleDefinition;

// Locale data
pub const locales = struct {
    pub const en = @import("locales/en.zig").en;
};

// Modules
const PersonModule = @import("modules/person.zig").Person;
const AddressModule = @import("modules/address.zig").Address;
const CompanyModule = @import("modules/company.zig").Company;
const InternetModule = @import("modules/internet.zig").Internet;
const PhoneModule = @import("modules/phone.zig").Phone;
const StringModule = @import("modules/string.zig").StringModule;

pub const PersonOptions = @import("modules/person.zig").PersonOptions;
pub const FullNameOptions = @import("modules/person.zig").FullNameOptions;
pub const StreetAddressOptions = @import("modules/address.zig").StreetAddressOptions;
pub const Gender = locale.Gender;

/// Main Faker struct providing access to all data generation modules
pub const Faker = struct {
    allocator: std.mem.Allocator,
    random: Random,
    locale_def: *const LocaleDefinition,

    // Module instances
    person: PersonModule,
    address: AddressModule,
    company: CompanyModule,
    internet: InternetModule,
    phone: PhoneModule,
    string: StringModule,

    /// Initialize Faker with optional seed and locale
    pub fn init(allocator: std.mem.Allocator, seed_value: ?u64, locale_def: ?*const LocaleDefinition) Faker {
        const selected_locale = locale_def orelse &locales.en;
        var faker = Faker{
            .allocator = allocator,
            .random = Random.init(seed_value),
            .locale_def = selected_locale,
            .person = undefined,
            .address = undefined,
            .company = undefined,
            .internet = undefined,
            .phone = undefined,
            .string = undefined,
        };

        faker.person = PersonModule.init(allocator, &faker.random, selected_locale);
        faker.address = AddressModule.init(allocator, &faker.random, selected_locale);
        faker.company = CompanyModule.init(allocator, &faker.random, selected_locale);
        faker.internet = InternetModule.init(allocator, &faker.random, selected_locale);
        faker.phone = PhoneModule.init(allocator, &faker.random, selected_locale);
        faker.string = StringModule.init(allocator, &faker.random);

        return faker;
    }

    /// Set a new seed for reproducible generation
    pub fn seed(self: *Faker, seed_value: u64) void {
        self.random = Random.init(seed_value);
        // Update all module references
        self.person.random = &self.random;
        self.address.random = &self.random;
        self.company.random = &self.random;
        self.internet.random = &self.random;
        self.phone.random = &self.random;
        self.string.random = &self.random;
    }

    /// Set a new locale
    pub fn setLocale(self: *Faker, new_locale: *const LocaleDefinition) void {
        self.locale_def = new_locale;
        // Update all module references
        self.person.locale = new_locale;
        self.address.locale = new_locale;
        self.company.locale = new_locale;
        self.internet.locale = new_locale;
        self.phone.locale = new_locale;
    }
};

// Tests
test "faker initialization" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const first_name = faker.person.firstName(.{});
    try std.testing.expect(first_name.len > 0);
}

test "faker with seed" {
    const allocator = std.testing.allocator;
    var faker1 = Faker.init(allocator, 12345, null);
    var faker2 = Faker.init(allocator, 12345, null);

    const name1 = faker1.person.firstName(.{});
    const name2 = faker2.person.firstName(.{});

    try std.testing.expectEqualStrings(name1, name2);
}

test "person module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const first = faker.person.firstName(.{});
    try std.testing.expect(first.len > 0);

    const last = faker.person.lastName();
    try std.testing.expect(last.len > 0);

    const full = try faker.person.fullName(.{});
    defer allocator.free(full);
    try std.testing.expect(full.len > 0);

    const job = faker.person.jobTitle();
    try std.testing.expect(job.len > 0);
}

test "address module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const city_name = faker.address.city();
    try std.testing.expect(city_name.len > 0);

    const state_name = faker.address.state();
    try std.testing.expect(state_name.len > 0);

    const zip = try faker.address.postalCode();
    defer allocator.free(zip);
    try std.testing.expect(zip.len > 0);

    const street = try faker.address.streetAddress(.{});
    defer allocator.free(street);
    try std.testing.expect(street.len > 0);
}

test "company module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const company_name = try faker.company.name();
    defer allocator.free(company_name);
    try std.testing.expect(company_name.len > 0);

    const industry_name = faker.company.industry();
    try std.testing.expect(industry_name.len > 0);

    const phrase = try faker.company.catchPhrase();
    defer allocator.free(phrase);
    try std.testing.expect(phrase.len > 0);
}

test "internet module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const email_addr = try faker.internet.email();
    defer allocator.free(email_addr);
    try std.testing.expect(email_addr.len > 0);
    try std.testing.expect(std.mem.indexOf(u8, email_addr, "@") != null);

    const url_str = try faker.internet.url();
    defer allocator.free(url_str);
    try std.testing.expect(url_str.len > 0);

    const user = try faker.internet.username();
    defer allocator.free(user);
    try std.testing.expect(user.len > 0);
}

test "phone module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const phone_number = try faker.phone.phoneNumber();
    defer allocator.free(phone_number);
    try std.testing.expect(phone_number.len > 0);
}

test "string module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const uuid_str = try faker.string.uuid();
    defer allocator.free(uuid_str);
    try std.testing.expectEqual(@as(usize, 36), uuid_str.len);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[8]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[13]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[18]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[23]);

    const nano = try faker.string.nanoid(21);
    defer allocator.free(nano);
    try std.testing.expectEqual(@as(usize, 21), nano.len);

    const alphanum = try faker.string.alphanumeric(10);
    defer allocator.free(alphanum);
    try std.testing.expectEqual(@as(usize, 10), alphanum.len);
}
