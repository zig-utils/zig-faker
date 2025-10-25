const std = @import("std");
const faker_mod = @import("zig-faker");
const Faker = faker_mod.Faker;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stdout_buffer: [4096]u8 = undefined;
    const stdout = std.fs.File.stdout().writer(&stdout_buffer);

    try stdout.print("=== Zig Faker Examples ===\n\n", .{});

    // Initialize faker (without seed for random data)
    var faker = Faker.init(allocator, null, null);

    // Person data
    try stdout.print("--- Person Data ---\n", .{});
    const first_name = faker.person.firstName(&faker.random, .{});
    try stdout.print("First Name: {s}\n", .{first_name});

    const last_name = faker.person.lastName(&faker.random);
    try stdout.print("Last Name: {s}\n", .{last_name});

    const full_name = try faker.person.fullName(&faker.random, .{});
    defer allocator.free(full_name);
    try stdout.print("Full Name: {s}\n", .{full_name});

    const full_name_with_prefix = try faker.person.fullName(&faker.random, .{ .prefix = true });
    defer allocator.free(full_name_with_prefix);
    try stdout.print("Full Name with Prefix: {s}\n", .{full_name_with_prefix});

    const job_title = faker.person.jobTitle(&faker.random);
    try stdout.print("Job Title: {s}\n", .{job_title});

    const gender = faker.person.gender(&faker.random);
    try stdout.print("Gender: {s}\n\n", .{gender});

    // Address data
    try stdout.print("--- Address Data ---\n", .{});
    const city = faker.address.city(&faker.random);
    try stdout.print("City: {s}\n", .{city});

    const state = faker.address.state(&faker.random);
    try stdout.print("State: {s}\n", .{state});

    const country = faker.address.country(&faker.random);
    try stdout.print("Country: {s}\n", .{country});

    const postal_code = try faker.address.postalCode(&faker.random);
    defer allocator.free(postal_code);
    try stdout.print("Postal Code: {s}\n", .{postal_code});

    const street_address = try faker.address.streetAddress(&faker.random, .{});
    defer allocator.free(street_address);
    try stdout.print("Street Address: {s}\n", .{street_address});

    const full_address = try faker.address.fullAddress(&faker.random);
    defer allocator.free(full_address);
    try stdout.print("Full Address: {s}\n\n", .{full_address});

    // Company data
    try stdout.print("--- Company Data ---\n", .{});
    const company_name = try faker.company.name(&faker.random);
    defer allocator.free(company_name);
    try stdout.print("Company Name: {s}\n", .{company_name});

    const industry = faker.company.industry(&faker.random);
    try stdout.print("Industry: {s}\n", .{industry});

    const catch_phrase = try faker.company.catchPhrase(&faker.random);
    defer allocator.free(catch_phrase);
    try stdout.print("Catch Phrase: {s}\n\n", .{catch_phrase});

    // Internet data
    try stdout.print("--- Internet Data ---\n", .{});
    const email = try faker.internet.email(&faker.random);
    defer allocator.free(email);
    try stdout.print("Email: {s}\n", .{email});

    const free_email = try faker.internet.freeEmail(&faker.random);
    defer allocator.free(free_email);
    try stdout.print("Free Email: {s}\n", .{free_email});

    const username = try faker.internet.username(&faker.random);
    defer allocator.free(username);
    try stdout.print("Username: {s}\n", .{username});

    const url = try faker.internet.url(&faker.random);
    defer allocator.free(url);
    try stdout.print("URL: {s}\n", .{url});

    const password = try faker.internet.password(&faker.random, 8, 16);
    defer allocator.free(password);
    try stdout.print("Password: {s}\n\n", .{password});

    // Phone data
    try stdout.print("--- Phone Data ---\n", .{});
    const phone_number = try faker.phone.phoneNumber(&faker.random);
    defer allocator.free(phone_number);
    try stdout.print("Phone Number: {s}\n\n", .{phone_number});

    // String utilities
    try stdout.print("--- String Utilities ---\n", .{});
    const uuid = try faker.string.uuid(&faker.random);
    defer allocator.free(uuid);
    try stdout.print("UUID: {s}\n", .{uuid});

    const nanoid = try faker.string.nanoid(&faker.random, 21);
    defer allocator.free(nanoid);
    try stdout.print("Nanoid: {s}\n", .{nanoid});

    const alphanum = try faker.string.alphanumeric(&faker.random, 16);
    defer allocator.free(alphanum);
    try stdout.print("Alphanumeric: {s}\n", .{alphanum});

    const hex = try faker.string.hexadecimal(&faker.random, 32);
    defer allocator.free(hex);
    try stdout.print("Hexadecimal: {s}\n\n", .{hex});

    // Seeded generation (reproducible)
    try stdout.print("--- Seeded Generation (Reproducible) ---\n", .{});
    var faker_seeded = Faker.init(allocator, 12345, null);
    const name1 = faker_seeded.person.firstName(&faker_seeded.random, .{});
    try stdout.print("Seeded Name 1: {s}\n", .{name1});

    var faker_seeded2 = Faker.init(allocator, 12345, null);
    const name2 = faker_seeded2.person.firstName(&faker_seeded2.random, .{});
    try stdout.print("Seeded Name 2 (same seed): {s}\n", .{name2});
    try stdout.print("Names match: {}\n\n", .{std.mem.eql(u8, name1, name2)});

    // Generate a realistic user profile
    try stdout.print("--- Complete User Profile ---\n", .{});
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

    try stdout.print("Name: {s}\n", .{profile_name});
    try stdout.print("Email: {s}\n", .{profile_email});
    try stdout.print("Phone: {s}\n", .{profile_phone});
    try stdout.print("Address: {s}\n", .{profile_address});
    try stdout.print("Company: {s}\n", .{profile_company});
    try stdout.print("Job Title: {s}\n", .{profile_job});

    try stdout.flush();
}
