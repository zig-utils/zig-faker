const std = @import("std");
const faker_module = @import("faker");
const Faker = faker_module.Faker;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // Initialize faker with a seed for reproducible results
    var faker = Faker.init(allocator, 12345, null);

    std.debug.print("\n🎲 Zig Faker - Comprehensive Demo\n", .{});
    std.debug.print("{s}\n\n", .{"=" ** 50});

    try demonstratePersonModule(&faker);
    try demonstrateAddressModule(&faker);
    try demonstrateCompanyModule(&faker);
    try demonstrateInternetModule(&faker);
    try demonstrateFoodModule(&faker);
    try demonstrateAnimalModule(&faker);
    try demonstrateWordModule(&faker);
    try demonstrateHelpersModule(&faker);
    try demonstrateAdvancedFeatures(&faker);

    std.debug.print("\n✨ Demo Complete!\n\n", .{});
}

fn demonstratePersonModule(faker: *Faker) !void {
    std.debug.print("👤 Person Module\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    const first_name = faker.person.firstName(&faker.random, .{});
    const last_name = faker.person.lastName(&faker.random);
    const full_name = try faker.person.fullName(&faker.random, .{});
    defer faker.allocator.free(full_name);

    std.debug.print("First Name: {s}\n", .{first_name});
    std.debug.print("Last Name: {s}\n", .{last_name});
    std.debug.print("Full Name: {s}\n", .{full_name});
    std.debug.print("Gender: {s}\n", .{faker.person.gender(&faker.random)});
    std.debug.print("Job Title: {s}\n", .{faker.person.jobTitle(&faker.random)});
    std.debug.print("\n", .{});
}

fn demonstrateAddressModule(faker: *Faker) !void {
    std.debug.print("🏠 Address Module\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    const street = try faker.address.streetAddress(&faker.random, .{});
    defer faker.allocator.free(street);

    std.debug.print("City: {s}\n", .{faker.address.city(&faker.random)});
    std.debug.print("State: {s}\n", .{faker.address.state(&faker.random)});
    std.debug.print("Street: {s}\n", .{street});
    const postal_code = try faker.address.postalCode(&faker.random);
    defer faker.allocator.free(postal_code);
    std.debug.print("Zip: {s}\n", .{postal_code});
    std.debug.print("Country: {s}\n", .{faker.address.country(&faker.random)});
    std.debug.print("\n", .{});
}

fn demonstrateCompanyModule(faker: *Faker) !void {
    std.debug.print("🏢 Company Module\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    const company_name = try faker.company.name(&faker.random);
    defer faker.allocator.free(company_name);

    std.debug.print("Company: {s}\n", .{company_name});
    std.debug.print("Industry: {s}\n", .{faker.company.industry(&faker.random)});
    std.debug.print("Buzzword: {s}\n", .{faker.company.buzzword(&faker.random)});
    std.debug.print("\n", .{});
}

fn demonstrateInternetModule(faker: *Faker) !void {
    std.debug.print("🌐 Internet Module\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    const email = try faker.internet.email(&faker.random);
    defer faker.allocator.free(email);

    const username = try faker.internet.username(&faker.random);
    defer faker.allocator.free(username);

    const url = try faker.internet.url(&faker.random);
    defer faker.allocator.free(url);

    std.debug.print("Email: {s}\n", .{email});
    std.debug.print("Username: {s}\n", .{username});
    std.debug.print("URL: {s}\n", .{url});
    std.debug.print("\n", .{});
}

fn demonstrateFoodModule(faker: *Faker) !void {
    std.debug.print("🍕 Food Module (Expanded!)\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    std.debug.print("Dish: {s}\n", .{faker.food.dish(&faker.random)});
    std.debug.print("Ingredient: {s}\n", .{faker.food.ingredient(&faker.random)});
    std.debug.print("Fruit: {s}\n", .{faker.food.fruit(&faker.random)});
    std.debug.print("Vegetable: {s}\n", .{faker.food.vegetable(&faker.random)});
    std.debug.print("Meat: {s}\n", .{faker.food.meat(&faker.random)});
    std.debug.print("Spice: {s}\n", .{faker.food.spice(&faker.random)});
    std.debug.print("\n", .{});
}

fn demonstrateAnimalModule(faker: *Faker) !void {
    std.debug.print("🦁 Animal Module (New Categories!)\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    std.debug.print("Dog: {s}\n", .{faker.animal.dog(&faker.random)});
    std.debug.print("Cat: {s}\n", .{faker.animal.cat(&faker.random)});
    std.debug.print("Horse: {s}\n", .{faker.animal.horse(&faker.random)});
    std.debug.print("Farm Animal: {s}\n", .{faker.animal.farm(&faker.random)});
    std.debug.print("Insect: {s}\n", .{faker.animal.insect(&faker.random)});
    std.debug.print("Wild Animal: {s}\n", .{faker.animal.wild(&faker.random)});
    std.debug.print("\n", .{});
}

fn demonstrateWordModule(faker: *Faker) !void {
    std.debug.print("📝 Word Module (2200+ Words!)\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    const adj = faker.word.adjective(&faker.random);
    const noun = faker.word.noun(&faker.random);
    const verb = faker.word.verb(&faker.random);
    const adverb = faker.word.adverb(&faker.random);

    std.debug.print("Adjective: {s}\n", .{adj});
    std.debug.print("Noun: {s}\n", .{noun});
    std.debug.print("Verb: {s}\n", .{verb});
    std.debug.print("Adverb: {s}\n", .{adverb});
    std.debug.print("\nSample Sentence: The {s} {s} will {s} {s}.\n\n",
        .{adj, noun, verb, adverb});
}

fn demonstrateHelpersModule(faker: *Faker) !void {
    std.debug.print("🛠️  Helpers Module (NEW!)\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    // Boolean and probability
    std.debug.print("Random Boolean: {}\n", .{faker.helpers.boolean(&faker.random)});
    std.debug.print("75%% Chance: {}\n", .{faker.helpers.maybe(&faker.random, 0.75)});

    // Weighted selection
    const priorities = [_][]const u8{ "Low", "Medium", "High", "Critical" };
    const weights = [_]f64{ 0.4, 0.3, 0.2, 0.1 };
    const priority = try faker.helpers.weightedArrayElement(
        []const u8,
        &faker.random,
        &priorities,
        &weights
    );
    std.debug.print("Weighted Priority: {s}\n", .{priority});

    // Unique ID
    const id = try faker.helpers.uniqueId(&faker.random);
    defer faker.allocator.free(id);
    std.debug.print("Unique ID: {s}\n", .{id});

    // Slugify
    const slug = try faker.helpers.slugify("Hello World Example");
    defer faker.allocator.free(slug);
    std.debug.print("Slugified: {s}\n", .{slug});

    // Hex color
    const color = try faker.helpers.hexColor(&faker.random);
    defer faker.allocator.free(color);
    std.debug.print("Hex Color: {s}\n", .{color});

    std.debug.print("\n", .{});
}

fn demonstrateAdvancedFeatures(faker: *Faker) !void {
    std.debug.print("🚀 Advanced Features\n", .{});
    std.debug.print("{s}\n", .{"-" ** 50});

    // Normal distribution for realistic ages
    const age = faker.helpers.normalDistribution(&faker.random, 35.0, 12.0);
    const clamped_age = faker.helpers.clamp(f64, age, 18.0, 80.0);
    std.debug.print("Realistic Age (Normal Dist): {d:.0}\n", .{clamped_age});

    // Array manipulation
    const items = [_][]const u8{ "Apple", "Banana", "Cherry", "Date", "Elderberry" };
    const selected = try faker.helpers.arrayElementsUnique(
        []const u8,
        &faker.random,
        &items,
        3
    );
    defer faker.allocator.free(selected);

    std.debug.print("Random 3 Fruits: ", .{});
    for (selected, 0..) |item, i| {
        if (i > 0) std.debug.print(", ", .{});
        std.debug.print("{s}", .{item});
    }
    std.debug.print("\n", .{});

    // Sequence generation
    const seq = try faker.helpers.sequence(1, 5, 1);
    defer faker.allocator.free(seq);
    std.debug.print("Sequence: [", .{});
    for (seq, 0..) |num, i| {
        if (i > 0) std.debug.print(", ", .{});
        std.debug.print("{d}", .{num});
    }
    std.debug.print("]\n", .{});

    // Finance module
    const cc = try faker.finance.creditCardNumber(&faker.random);
    defer faker.allocator.free(cc);
    std.debug.print("Credit Card: {s}\n", .{cc});

    // Git module
    const commit = try faker.git.conventionalCommit(&faker.random);
    defer faker.allocator.free(commit);
    std.debug.print("Git Commit: {s}\n", .{commit});

    std.debug.print("\n", .{});
}
