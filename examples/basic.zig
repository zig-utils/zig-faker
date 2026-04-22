const std = @import("std");
const faker_mod = @import("zig_faker");
const Faker = faker_mod.Faker;

pub fn main() !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    std.debug.print("=== Zig Faker Examples ===\n\n", .{});

    // Initialize faker (without seed for random data)
    var faker = Faker.init(allocator, null, null);

    // Person data
    std.debug.print("--- Person Data ---\n", .{});
    const first_name = faker.person.firstName(&faker.random, .{});
    std.debug.print("First Name: {s}\n", .{first_name});

    const last_name = faker.person.lastName(&faker.random);
    std.debug.print("Last Name: {s}\n", .{last_name});

    const full_name = try faker.person.fullName(&faker.random, .{});
    defer allocator.free(full_name);
    std.debug.print("Full Name: {s}\n", .{full_name});

    const full_name_with_prefix = try faker.person.fullName(&faker.random, .{ .prefix = true });
    defer allocator.free(full_name_with_prefix);
    std.debug.print("Full Name with Prefix: {s}\n", .{full_name_with_prefix});

    const job_title = faker.person.jobTitle(&faker.random);
    std.debug.print("Job Title: {s}\n", .{job_title});

    const gender = faker.person.gender(&faker.random);
    std.debug.print("Gender: {s}\n\n", .{gender});

    // Address data
    std.debug.print("--- Address Data ---\n", .{});
    const city = faker.address.city(&faker.random);
    std.debug.print("City: {s}\n", .{city});

    const state = faker.address.state(&faker.random);
    std.debug.print("State: {s}\n", .{state});

    const country = faker.address.country(&faker.random);
    std.debug.print("Country: {s}\n", .{country});

    const postal_code = try faker.address.postalCode(&faker.random);
    defer allocator.free(postal_code);
    std.debug.print("Postal Code: {s}\n", .{postal_code});

    const street_address = try faker.address.streetAddress(&faker.random, .{});
    defer allocator.free(street_address);
    std.debug.print("Street Address: {s}\n", .{street_address});

    const full_address = try faker.address.fullAddress(&faker.random);
    defer allocator.free(full_address);
    std.debug.print("Full Address: {s}\n\n", .{full_address});

    // Company data
    std.debug.print("--- Company Data ---\n", .{});
    const company_name = try faker.company.name(&faker.random);
    defer allocator.free(company_name);
    std.debug.print("Company Name: {s}\n", .{company_name});

    const industry = faker.company.industry(&faker.random);
    std.debug.print("Industry: {s}\n", .{industry});

    const catch_phrase = try faker.company.catchPhrase(&faker.random);
    defer allocator.free(catch_phrase);
    std.debug.print("Catch Phrase: {s}\n\n", .{catch_phrase});

    // Internet data
    std.debug.print("--- Internet Data ---\n", .{});
    const email = try faker.internet.email(&faker.random);
    defer allocator.free(email);
    std.debug.print("Email: {s}\n", .{email});

    const free_email = try faker.internet.freeEmail(&faker.random);
    defer allocator.free(free_email);
    std.debug.print("Free Email: {s}\n", .{free_email});

    const username = try faker.internet.username(&faker.random);
    defer allocator.free(username);
    std.debug.print("Username: {s}\n", .{username});

    const url = try faker.internet.url(&faker.random);
    defer allocator.free(url);
    std.debug.print("URL: {s}\n", .{url});

    const password = try faker.internet.password(&faker.random, 8, 16);
    defer allocator.free(password);
    std.debug.print("Password: {s}\n\n", .{password});

    // Phone data
    std.debug.print("--- Phone Data ---\n", .{});
    const phone_number = try faker.phone.phoneNumber(&faker.random);
    defer allocator.free(phone_number);
    std.debug.print("Phone Number: {s}\n\n", .{phone_number});

    // String utilities
    std.debug.print("--- String Utilities ---\n", .{});
    const uuid = try faker.string.uuid(&faker.random);
    defer allocator.free(uuid);
    std.debug.print("UUID: {s}\n", .{uuid});

    const nanoid = try faker.string.nanoid(&faker.random, 21);
    defer allocator.free(nanoid);
    std.debug.print("Nanoid: {s}\n", .{nanoid});

    const alphanum = try faker.string.alphanumeric(&faker.random, 16);
    defer allocator.free(alphanum);
    std.debug.print("Alphanumeric: {s}\n", .{alphanum});

    const hex = try faker.string.hexadecimal(&faker.random, 32);
    defer allocator.free(hex);
    std.debug.print("Hexadecimal: {s}\n\n", .{hex});

    // Seeded generation (reproducible)
    std.debug.print("--- Seeded Generation (Reproducible) ---\n", .{});
    var faker_seeded = Faker.init(allocator, 12345, null);
    const name1 = faker_seeded.person.firstName(&faker_seeded.random, .{});
    std.debug.print("Seeded Name 1: {s}\n", .{name1});

    var faker_seeded2 = Faker.init(allocator, 12345, null);
    const name2 = faker_seeded2.person.firstName(&faker_seeded2.random, .{});
    std.debug.print("Seeded Name 2 (same seed): {s}\n", .{name2});
    std.debug.print("Names match: {}\n\n", .{std.mem.eql(u8, name1, name2)});

    // Generate a realistic user profile
    std.debug.print("--- Complete User Profile ---\n", .{});
    const profile_name = try faker.person.fullName(&faker.random, .{ .prefix = true });
    defer allocator.free(profile_name);
    const profile_email = try faker.internet.email(&faker.random);
    defer allocator.free(profile_email);
    const profile_phone = try faker.phone.phoneNumber(&faker.random);
    defer allocator.free(profile_phone);
    const profile_address = try faker.address.fullAddress(&faker.random);
    defer allocator.free(profile_address);
    const profile_company = try faker.company.name(&faker.random);
    defer allocator.free(profile_company);
    const profile_job = faker.person.jobTitle(&faker.random);

    std.debug.print("Name: {s}\n", .{profile_name});
    std.debug.print("Email: {s}\n", .{profile_email});
    std.debug.print("Phone: {s}\n", .{profile_phone});
    std.debug.print("Address: {s}\n", .{profile_address});
    std.debug.print("Company: {s}\n", .{profile_company});
    std.debug.print("Job Title: {s}\n", .{profile_job});

    
}
