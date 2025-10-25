# Zig Faker

A high-performance, lightweight fake data generator for Zig, inspired by [ts-mocker](https://github.com/stacksjs/ts-mocker). Generate realistic fake data for testing, prototyping, and development.

## Features

- **High Performance**: Optimized for speed with minimal allocations
- **Comprehensive Data**: 6+ major data categories with hundreds of data points
- **Seeded Generation**: Reproducible random data with optional seeding
- **Locale Support**: Extensible locale system (English included)
- **Type Safe**: Fully typed Zig API
- **Zero External Dependencies**: Pure Zig implementation
- **Modular Design**: Use only what you need

## Installation

Add zig-faker to your `build.zig.zon`:

```zig
.dependencies = .{
    .@"zig-faker" = .{
        .url = "https://github.com/yourusername/zig-faker/archive/main.tar.gz",
        .hash = "...",
    },
},
```

Then in your `build.zig`:

```zig
const zig_faker = b.dependency("zig-faker", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("zig-faker", zig_faker.module("zig-faker"));
```

## Quick Start

```zig
const std = @import("std");
const Faker = @import("zig-faker").Faker;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Initialize faker (no seed = random data)
    var faker = Faker.init(allocator, null, null);

    // Generate data
    const name = try faker.person.fullName(.{});
    defer allocator.free(name);

    const email = try faker.internet.email();
    defer allocator.free(email);

    const phone = try faker.phone.phoneNumber();
    defer allocator.free(phone);

    std.debug.print("Name: {s}\n", .{name});
    std.debug.print("Email: {s}\n", .{email});
    std.debug.print("Phone: {s}\n", .{phone});
}
```

## API Reference

### Person Module

```zig
// First name with optional gender
const first = faker.person.firstName(.{ .gender = .male });

// Last name
const last = faker.person.lastName();

// Full name with options
const full = try faker.person.fullName(.{
    .prefix = true,   // Add Mr./Mrs./etc.
    .suffix = false,  // Add Jr./Sr./etc.
    .gender = .female,
});
defer allocator.free(full);

// Name components
const prefix = faker.person.prefix();    // Mr., Mrs., Dr., etc.
const suffix = faker.person.suffix();    // Jr., Sr., III, etc.
const gender = faker.person.gender();    // Male, Female, Non-binary, etc.
const job = faker.person.jobTitle();     // Software Engineer, etc.
```

### Address Module

```zig
// City, state, country
const city = faker.address.city();
const state = faker.address.state();
const state_abbr = faker.address.stateAbbr();
const country = faker.address.country();

// Street address
const street = try faker.address.streetAddress(.{
    .use_full_address = false,
});
defer allocator.free(street);

// Full address
const address = try faker.address.fullAddress();
defer allocator.free(address);

// Postal code
const zip = try faker.address.postalCode();
defer allocator.free(zip);

// Direction
const direction = faker.address.direction(); // North, South, etc.
```

### Company Module

```zig
// Company name
const company = try faker.company.name();
defer allocator.free(company);

// Company components
const suffix = faker.company.suffix();       // Inc, LLC, Corp, etc.
const industry = faker.company.industry();   // Technology, Finance, etc.
const buzzword = faker.company.buzzword();   // synergy, leverage, etc.
const descriptor = faker.company.descriptor(); // innovative, leading, etc.

// Catch phrase
const phrase = try faker.company.catchPhrase();
defer allocator.free(phrase);
```

### Internet Module

```zig
// Email addresses
const email = try faker.internet.email();
defer allocator.free(email);

const free_email = try faker.internet.freeEmail();
defer allocator.free(free_email);

// Domain components
const domain = try faker.internet.domainName();
defer allocator.free(domain);

const domain_word = faker.internet.domainWord();
const domain_suffix = faker.internet.domainSuffix();

// URLs
const url = try faker.internet.url();
defer allocator.free(url);

// Username
const username = try faker.internet.username();
defer allocator.free(username);

// Password
const password = try faker.internet.password(8, 16); // min, max length
defer allocator.free(password);
```

### Phone Module

```zig
// Phone number (locale-specific format)
const phone = try faker.phone.phoneNumber();
defer allocator.free(phone);
```

### String Module

```zig
// UUID v4
const uuid = try faker.string.uuid();
defer allocator.free(uuid);

// Nanoid (URL-friendly unique ID)
const nanoid = try faker.string.nanoid(21);
defer allocator.free(nanoid);

// Random strings
const alphanum = try faker.string.alphanumeric(16);
defer allocator.free(alphanum);

const alpha = try faker.string.alpha(10);
defer allocator.free(alpha);

const numeric = try faker.string.numeric(8);
defer allocator.free(numeric);

const hex = try faker.string.hexadecimal(32);
defer allocator.free(hex);
```

## Seeded Generation

For reproducible random data (useful for testing):

```zig
// Same seed = same data
var faker1 = Faker.init(allocator, 12345, null);
var faker2 = Faker.init(allocator, 12345, null);

const name1 = faker1.person.firstName(.{});
const name2 = faker2.person.firstName(.{});
// name1 == name2 (guaranteed)

// Change seed at runtime
faker1.seed(54321);
const name3 = faker1.person.firstName(.{});
// name3 will be different
```

## Locale Support

```zig
const locales = @import("zig-faker").locales;

// Use specific locale
var faker = Faker.init(allocator, null, &locales.en);

// Change locale at runtime
faker.setLocale(&locales.es); // Switch to Spanish (when available)
```

Currently supported locales:
- English (en) - Built-in

More locales coming soon!

## Data Categories

### Person
- First names (male, female, neutral)
- Last names
- Name prefixes/suffixes
- Gender identities
- Job titles

### Address
- Street names and numbers
- Cities, states, countries
- Postal codes
- Directions
- Full addresses

### Company
- Company names and suffixes
- Industries
- Business buzzwords
- Descriptors
- Catch phrases

### Internet
- Email addresses (custom and free providers)
- Domain names
- URLs
- Usernames
- Passwords

### Phone
- Phone numbers (locale-specific formats)

### String Utilities
- UUID v4 generation
- Nanoid generation
- Alphanumeric, alphabetic, numeric strings
- Hexadecimal strings

## Building and Testing

```bash
# Run tests
zig build test

# Run example
zig build example

# Run benchmarks
zig build benchmark
```

## Performance

Zig Faker is designed for high performance with minimal memory allocations:

- **UUID Generation**: Millions of operations per second
- **Email Generation**: Millions of operations per second
- **Name Generation**: Tens of millions of operations per second

Run `zig build benchmark` to see performance on your system.

## Memory Management

Zig Faker follows Zig's explicit memory management philosophy:

- Functions that return const strings (e.g., `firstName()`, `city()`) return pointers to static data - no deallocation needed
- Functions that return dynamic strings (e.g., `fullName()`, `email()`) allocate memory - you must free the result

```zig
// No deallocation needed (const string)
const first = faker.person.firstName(.{});

// Must deallocate (dynamic string)
const full = try faker.person.fullName(.{});
defer allocator.free(full);
```

## Examples

### Generate User Profile

```zig
const profile = .{
    .name = try faker.person.fullName(.{ .prefix = true }),
    .email = try faker.internet.email(),
    .phone = try faker.phone.phoneNumber(),
    .address = try faker.address.fullAddress(),
    .company = try faker.company.name(),
    .job_title = faker.person.jobTitle(),
};

defer allocator.free(profile.name);
defer allocator.free(profile.email);
defer allocator.free(profile.phone);
defer allocator.free(profile.address);
defer allocator.free(profile.company);
```

### Seed Database with Test Data

```zig
var faker = Faker.init(allocator, 12345, null); // Seeded for reproducibility

var users = std.ArrayList(User).init(allocator);
defer users.deinit();

for (0..100) |_| {
    const user = User{
        .name = try faker.person.fullName(.{}),
        .email = try faker.internet.email(),
        .phone = try faker.phone.phoneNumber(),
    };
    try users.append(user);
}
```

### Generate Test Fixtures

```zig
test "user registration" {
    var faker = Faker.init(std.testing.allocator, null, null);

    const email = try faker.internet.email();
    defer std.testing.allocator.free(email);

    const password = try faker.internet.password(8, 16);
    defer std.testing.allocator.free(password);

    const result = try registerUser(email, password);
    try std.testing.expect(result.success);
}
```

## Roadmap

- [ ] Additional locales (Spanish, French, German, etc.)
- [ ] More data categories (Food, Animal, Sport, Music, etc.)
- [ ] Date/time generation
- [ ] Lorem ipsum text generation
- [ ] Color generation
- [ ] Financial data (credit cards, IBANs, etc.)
- [ ] CLI tool for data generation
- [ ] Advanced features (validation, constraints, relationships)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

## Acknowledgments

Inspired by [ts-mocker](https://github.com/stacksjs/ts-mocker) - a blazing-fast TypeScript faker library.

## Related Projects

- [ts-mocker](https://github.com/stacksjs/ts-mocker) - TypeScript/JavaScript version
- [@faker-js/faker](https://github.com/faker-js/faker) - Popular JavaScript faker library

### Food Module

```zig
// Food items
const dish = faker.food.dish();           // Pizza, Burger, Sushi, etc.
const ingredient = faker.food.ingredient(); // Tomato, Onion, Garlic, etc.
const fruit = faker.food.fruit();         // Apple, Banana, Orange, etc.
const vegetable = faker.food.vegetable(); // Carrot, Broccoli, etc.
const meat = faker.food.meat();           // Chicken, Beef, Pork, etc.
const spice = faker.food.spice();         // Pepper, Salt, Paprika, etc.

// Recipe name
const recipe = try faker.food.recipe();
defer allocator.free(recipe);
```

### Animal Module

```zig
// Animal breeds and species
const dog = faker.animal.dog();           // Labrador, German Shepherd, etc.
const cat = faker.animal.cat();           // Persian, Maine Coon, etc.
const bird = faker.animal.bird();         // Sparrow, Robin, Eagle, etc.
const fish = faker.animal.fish();         // Goldfish, Koi, Betta, etc.
const animal_type = faker.animal.type_(); // Mammal, Bird, Fish, etc.

// Pet names
const pet_name = faker.animal.petName();  // Max, Bella, Charlie, etc.
```

### Date Module

```zig
// Timestamps
const timestamp = faker.date.timestamp();    // Random Unix timestamp
const past_date = faker.date.past(30);      // Within last 30 days
const future_date = faker.date.future(30);  // Within next 30 days
const recent = faker.date.recent();         // Within last 7 days
const soon = faker.date.soon();             // Within next 7 days

// Date components
const weekday = faker.date.weekday();       // Monday, Tuesday, etc.
const month = faker.date.month();           // January, February, etc.

// Formatted dates
const date_str = try faker.date.dateString(); // 2024-03-15
defer allocator.free(date_str);

const time_str = try faker.date.timeString(); // 14:30:45
defer allocator.free(time_str);

const iso = try faker.date.iso8601();        // 2024-03-15T14:30:45Z
defer allocator.free(iso);
```

### Number Module

```zig
// Basic numbers
const int_num = faker.number.int(1, 100);      // Random integer in range
const float_num = faker.number.float(0.0, 1.0); // Random float in range
const percent = faker.number.percentage(2);     // Random percentage

// Special numbers
const prime_num = faker.number.prime(100);      // Random prime <= 100
const even_num = faker.number.even(1, 100);     // Random even number
const odd_num = faker.number.odd(1, 100);       // Random odd number

// Number formats
const binary = try faker.number.binary(8);      // 10110101
defer allocator.free(binary);

const octal = try faker.number.octal(6);        // 742531
defer allocator.free(octal);

const hex = try faker.number.hexadecimal(8);    // a3f5c2d1
defer allocator.free(hex);
```

### Color Module

```zig
// Color names
const color_name = faker.color.name();        // Red, Blue, Green, etc.
const css_color = faker.color.cssColor();     // aliceblue, antiquewhite, etc.

// Color formats
const hex_color = try faker.color.hex();      // #FF5733
defer allocator.free(hex_color);

const rgb = try faker.color.rgb();            // rgb(255, 87, 51)
defer allocator.free(rgb);

const rgba = try faker.color.rgba();          // rgba(255, 87, 51, 0.8)
defer allocator.free(rgba);

const hsl = try faker.color.hsl();            // hsl(120, 50%, 50%)
defer allocator.free(hsl);

const hsla = try faker.color.hsla();          // hsla(120, 50%, 50%, 0.8)
defer allocator.free(hsla);

// RGB array
const rgb_array = faker.color.rgbArray();     // [255, 87, 51]
```

### Lorem Module

```zig
// Words
const word = faker.lorem.word();              // lorem, ipsum, dolor, etc.

const words = try faker.lorem.words(5);       // 5 random words
defer allocator.free(words);

// Sentences
const sentence = try faker.lorem.sentence();  // Random sentence with period
defer allocator.free(sentence);

const sentences = try faker.lorem.sentences(3); // 3 sentences
defer allocator.free(sentences);

// Paragraphs
const paragraph = try faker.lorem.paragraph(); // Random paragraph
defer allocator.free(paragraph);

const paragraphs = try faker.lorem.paragraphs(2); // 2 paragraphs
defer allocator.free(paragraphs);

// Other formats
const lines = try faker.lorem.lines(5);       // 5 lines of text
defer allocator.free(lines);

const slug = try faker.lorem.slug(3);         // lorem-ipsum-dolor
defer allocator.free(slug);

const text = try faker.lorem.text(100);       // ~100 characters of text
defer allocator.free(text);
```

