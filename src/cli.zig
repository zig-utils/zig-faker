const std = @import("std");
const Faker = @import("faker.zig").Faker;
const locales = @import("faker.zig").locales;

const VERSION = "1.0.0";

const Command = enum {
    generate,
    categories,
    methods,
    locales_list,
    batch,
    help,
    version,
};

const OutputFormat = enum {
    text,
    json,
    csv,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        printHelp();
        return;
    }

    const command_str = args[1];
    const command = parseCommand(command_str) orelse {
        std.debug.print("Unknown command: {s}\n\n", .{command_str});
        printHelp();
        return;
    };

    switch (command) {
        .help => printHelp(),
        .version => printVersion(),
        .categories => try listCategories(),
        .methods => try listMethods(allocator, args),
        .locales_list => try listLocales(),
        .generate => try generateData(allocator, args),
        .batch => try batchGenerate(allocator, args),
    }
}

fn parseCommand(cmd: []const u8) ?Command {
    if (std.mem.eql(u8, cmd, "generate") or std.mem.eql(u8, cmd, "gen") or std.mem.eql(u8, cmd, "g")) {
        return .generate;
    } else if (std.mem.eql(u8, cmd, "categories") or std.mem.eql(u8, cmd, "cat")) {
        return .categories;
    } else if (std.mem.eql(u8, cmd, "methods") or std.mem.eql(u8, cmd, "m")) {
        return .methods;
    } else if (std.mem.eql(u8, cmd, "locales") or std.mem.eql(u8, cmd, "loc")) {
        return .locales_list;
    } else if (std.mem.eql(u8, cmd, "batch") or std.mem.eql(u8, cmd, "b")) {
        return .batch;
    } else if (std.mem.eql(u8, cmd, "help") or std.mem.eql(u8, cmd, "--help") or std.mem.eql(u8, cmd, "-h")) {
        return .help;
    } else if (std.mem.eql(u8, cmd, "version") or std.mem.eql(u8, cmd, "--version") or std.mem.eql(u8, cmd, "-v")) {
        return .version;
    }
    return null;
}

fn printVersion() void {
    std.debug.print("faker v{s}\n", .{VERSION});
}

fn printHelp() void {
    std.debug.print(
        \\faker - Fake data generator for the command line
        \\
        \\USAGE:
        \\    faker <command> [options]
        \\
        \\COMMANDS:
        \\    generate, gen, g       Generate fake data
        \\    categories, cat        List available data categories
        \\    methods, m             List methods for a category
        \\    locales, loc           List available locales
        \\    batch, b               Generate batch data from template
        \\    help, --help, -h       Show this help message
        \\    version, --version, -v Show version information
        \\
        \\GENERATE OPTIONS:
        \\    faker generate <category> <method>
        \\    --count, -c <n>        Generate N items (default: 1)
        \\    --seed, -s <seed>      Use specific seed for reproducibility
        \\    --locale, -l <locale>  Use specific locale (default: en)
        \\    --json                 Output as JSON
        \\    --csv                  Output as CSV
        \\
        \\EXAMPLES:
        \\    # Generate a single name
        \\    faker generate person firstName
        \\
        \\    # Generate 10 emails
        \\    faker generate internet email --count 10
        \\
        \\    # Generate with seed (reproducible)
        \\    faker generate person fullName --seed 12345
        \\
        \\    # Generate with specific locale
        \\    faker generate address city --locale es_MX
        \\
        \\    # Generate as JSON
        \\    faker generate person fullName --json --count 5
        \\
        \\    # List available categories
        \\    faker categories
        \\
        \\    # List methods for person category
        \\    faker methods person
        \\
        \\    # List available locales
        \\    faker locales
        \\
        \\
    , .{});
}

fn listCategories() !void {
    std.debug.print("Available categories:\n\n", .{});
    std.debug.print("  person      - Names, job titles, gender\n", .{});
    std.debug.print("  address     - Cities, streets, postal codes\n", .{});
    std.debug.print("  company     - Company names, industries\n", .{});
    std.debug.print("  internet    - Emails, domains, URLs\n", .{});
    std.debug.print("  phone       - Phone numbers\n", .{});
    std.debug.print("  string      - UUIDs, random strings\n", .{});
    std.debug.print("  food        - Dishes, ingredients, fruits\n", .{});
    std.debug.print("  animal      - Dog breeds, cat breeds, species\n", .{});
    std.debug.print("  date        - Timestamps, dates\n", .{});
    std.debug.print("  number      - Random numbers, percentages\n", .{});
    std.debug.print("  color       - Color names, hex colors, RGB\n", .{});
    std.debug.print("  lorem       - Lorem ipsum text\n", .{});
    std.debug.print("  finance     - Credit cards, IBANs, currencies\n", .{});
    std.debug.print("  database    - Table names, column names\n", .{});
    std.debug.print("  git         - Commit messages, SHAs\n", .{});
    std.debug.print("  image       - Image URLs, dimensions\n", .{});
    std.debug.print("  vehicle     - Car manufacturers, models\n", .{});
    std.debug.print("  sport       - Sport names, teams\n", .{});
    std.debug.print("  music       - Genres, artists, instruments\n", .{});
    std.debug.print("  book        - Titles, authors, publishers\n", .{});
    std.debug.print("\nUse 'faker methods <category>' to see available methods.\n", .{});
}

fn listMethods(allocator: std.mem.Allocator, args: []const []const u8) !void {
    if (args.len < 3) {
        std.debug.print("Usage: faker methods <category>\n", .{});
        std.debug.print("Example: faker methods person\n", .{});
        return;
    }

    const category = args[2];

    std.debug.print("Methods for '{s}':\n\n", .{category});

    if (std.mem.eql(u8, category, "person")) {
        std.debug.print("  firstName       - Generate a first name\n", .{});
        std.debug.print("  lastName        - Generate a last name\n", .{});
        std.debug.print("  fullName        - Generate a full name\n", .{});
        std.debug.print("  prefix          - Generate name prefix (Mr., Mrs., etc.)\n", .{});
        std.debug.print("  suffix          - Generate name suffix (Jr., Sr., etc.)\n", .{});
        std.debug.print("  gender          - Generate a gender\n", .{});
        std.debug.print("  jobTitle        - Generate a job title\n", .{});
    } else if (std.mem.eql(u8, category, "address")) {
        std.debug.print("  city            - Generate a city name\n", .{});
        std.debug.print("  state           - Generate a state/province\n", .{});
        std.debug.print("  stateAbbr       - Generate state abbreviation\n", .{});
        std.debug.print("  country         - Generate a country name\n", .{});
        std.debug.print("  postalCode      - Generate a postal code\n", .{});
        std.debug.print("  streetName      - Generate a street name\n", .{});
        std.debug.print("  streetAddress   - Generate a street address\n", .{});
        std.debug.print("  fullAddress     - Generate a full address\n", .{});
    } else if (std.mem.eql(u8, category, "internet")) {
        std.debug.print("  email           - Generate an email address\n", .{});
        std.debug.print("  freeEmail       - Generate a free email address\n", .{});
        std.debug.print("  domainName      - Generate a domain name\n", .{});
        std.debug.print("  domainSuffix    - Generate a domain suffix\n", .{});
        std.debug.print("  url             - Generate a URL\n", .{});
        std.debug.print("  username        - Generate a username\n", .{});
        std.debug.print("  password        - Generate a password\n", .{});
    } else if (std.mem.eql(u8, category, "phone")) {
        std.debug.print("  phoneNumber     - Generate a phone number\n", .{});
    } else if (std.mem.eql(u8, category, "string")) {
        std.debug.print("  uuid            - Generate a UUID v4\n", .{});
        std.debug.print("  nanoid          - Generate a nanoid\n", .{});
        std.debug.print("  alphanumeric    - Generate alphanumeric string\n", .{});
        std.debug.print("  alpha           - Generate alphabetic string\n", .{});
        std.debug.print("  numeric         - Generate numeric string\n", .{});
        std.debug.print("  hex             - Generate hexadecimal string\n", .{});
    } else {
        std.debug.print("Category not found. Use 'faker categories' to see available categories.\n", .{});
    }

    _ = allocator;
}

fn listLocales() !void {
    std.debug.print("Available locales:\n\n", .{});
    std.debug.print("Base locales (27):\n", .{});
    std.debug.print("  af, ar, az, cs, da, de, en, eo, es, fa, fi, fr, he,\n", .{});
    std.debug.print("  hi, it, ja, ko, nl, no, pl, pt, sv, tl, tr, uk, zh, zu\n", .{});
    std.debug.print("\nRegional variants (28):\n", .{});
    std.debug.print("  English: en_US, en_GB, en_AU, en_CA, en_GH, en_HK, en_IE, en_IN, en_NG, en_ZA\n", .{});
    std.debug.print("  German:  de_AT, de_CH, de_DE\n", .{});
    std.debug.print("  Spanish: es_ES, es_MX\n", .{});
    std.debug.print("  French:  fr_BE, fr_CA, fr_CH, fr_FR, fr_LU, fr_SN\n", .{});
    std.debug.print("  Portuguese: pt_BR, pt_MZ, pt_PT\n", .{});
    std.debug.print("  Chinese: zh_CN, zh_TW\n", .{});
    std.debug.print("  African: af_ZA, zu_ZA\n", .{});
    std.debug.print("\nUse --locale <code> to generate with a specific locale.\n", .{});
}

fn generateData(allocator: std.mem.Allocator, args: []const []const u8) !void {
    if (args.len < 4) {
        std.debug.print("Usage: faker generate <category> <method> [options]\n", .{});
        std.debug.print("Example: faker generate person firstName --count 10\n", .{});
        return;
    }

    const category = args[2];
    const method = args[3];

    // Parse options
    var count: usize = 1;
    var seed: ?u64 = null;
    var locale_code: []const u8 = "en";
    var output_format: OutputFormat = .text;

    var i: usize = 4;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--count") or std.mem.eql(u8, arg, "-c")) {
            if (i + 1 < args.len) {
                count = try std.fmt.parseInt(usize, args[i + 1], 10);
                i += 1;
            }
        } else if (std.mem.eql(u8, arg, "--seed") or std.mem.eql(u8, arg, "-s")) {
            if (i + 1 < args.len) {
                seed = try std.fmt.parseInt(u64, args[i + 1], 10);
                i += 1;
            }
        } else if (std.mem.eql(u8, arg, "--locale") or std.mem.eql(u8, arg, "-l")) {
            if (i + 1 < args.len) {
                locale_code = args[i + 1];
                i += 1;
            }
        } else if (std.mem.eql(u8, arg, "--json")) {
            output_format = .json;
        } else if (std.mem.eql(u8, arg, "--csv")) {
            output_format = .csv;
        }
    }

    // Get locale
    const locale_def = getLocale(locale_code) orelse &locales.en;

    // Initialize faker
    var faker = Faker.init(allocator, seed, locale_def);

    // Generate data based on category and method
    var results = std.ArrayList([]const u8).initCapacity(allocator, count) catch unreachable;
    defer {
        for (results.items) |result| {
            allocator.free(result);
        }
        results.deinit(allocator);
    }

    var idx: usize = 0;
    while (idx < count) : (idx += 1) {
        const result = try generateSingle(allocator, &faker, category, method);
        if (result) |r| {
            try results.append(allocator, r);
        } else {
            std.debug.print("Unknown category/method: {s}.{s}\n", .{ category, method });
            return;
        }
    }

    // Output results
    try outputResults(allocator, results.items, output_format);
}

fn generateSingle(allocator: std.mem.Allocator, faker: *Faker, category: []const u8, method: []const u8) !?[]const u8 {
    if (std.mem.eql(u8, category, "person")) {
        if (std.mem.eql(u8, method, "firstName")) {
            const name = faker.person.firstName(&faker.random, .{});
            return try allocator.dupe(u8, name);
        } else if (std.mem.eql(u8, method, "lastName")) {
            const name = faker.person.lastName(&faker.random);
            return try allocator.dupe(u8, name);
        } else if (std.mem.eql(u8, method, "fullName")) {
            return try faker.person.fullName(&faker.random, .{});
        } else if (std.mem.eql(u8, method, "prefix")) {
            const val = faker.person.prefix(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "suffix")) {
            const val = faker.person.suffix(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "gender")) {
            const val = faker.person.gender(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "jobTitle")) {
            const val = faker.person.jobTitle(&faker.random);
            return try allocator.dupe(u8, val);
        }
    } else if (std.mem.eql(u8, category, "address")) {
        if (std.mem.eql(u8, method, "city")) {
            const val = faker.address.city(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "state")) {
            const val = faker.address.state(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "stateAbbr")) {
            const val = faker.address.stateAbbr(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "country")) {
            const val = faker.address.country(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "postalCode")) {
            return try faker.address.postalCode(&faker.random);
        } else if (std.mem.eql(u8, method, "streetName")) {
            const val = faker.address.streetName(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "streetAddress")) {
            return try faker.address.streetAddress(&faker.random, .{});
        } else if (std.mem.eql(u8, method, "fullAddress")) {
            return try faker.address.fullAddress(&faker.random);
        }
    } else if (std.mem.eql(u8, category, "internet")) {
        if (std.mem.eql(u8, method, "email")) {
            return try faker.internet.email(&faker.random);
        } else if (std.mem.eql(u8, method, "freeEmail")) {
            return try faker.internet.freeEmail(&faker.random);
        } else if (std.mem.eql(u8, method, "domainName")) {
            return try faker.internet.domainName(&faker.random);
        } else if (std.mem.eql(u8, method, "domainSuffix")) {
            const val = faker.internet.domainSuffix(&faker.random);
            return try allocator.dupe(u8, val);
        } else if (std.mem.eql(u8, method, "url")) {
            return try faker.internet.url(&faker.random);
        } else if (std.mem.eql(u8, method, "username")) {
            return try faker.internet.username(&faker.random);
        } else if (std.mem.eql(u8, method, "password")) {
            return try faker.internet.password(&faker.random, 8, 16);
        }
    } else if (std.mem.eql(u8, category, "phone")) {
        if (std.mem.eql(u8, method, "phoneNumber")) {
            return try faker.phone.phoneNumber(&faker.random);
        }
    } else if (std.mem.eql(u8, category, "string")) {
        if (std.mem.eql(u8, method, "uuid")) {
            return try faker.string.uuid(&faker.random);
        } else if (std.mem.eql(u8, method, "nanoid")) {
            return try faker.string.nanoid(&faker.random, 21);
        } else if (std.mem.eql(u8, method, "alphanumeric")) {
            return try faker.string.alphanumeric(&faker.random, 16);
        } else if (std.mem.eql(u8, method, "alpha")) {
            return try faker.string.alpha(&faker.random, 10);
        } else if (std.mem.eql(u8, method, "numeric")) {
            return try faker.string.numeric(&faker.random, 8);
        } else if (std.mem.eql(u8, method, "hex")) {
            return try faker.string.hexadecimal(&faker.random, 16);
        }
    }

    return null;
}

fn outputResults(allocator: std.mem.Allocator, results: []const []const u8, format: OutputFormat) !void {
    switch (format) {
        .text => {
            for (results) |result| {
                std.debug.print("{s}\n", .{result});
            }
        },
        .json => {
            std.debug.print("[\n", .{});
            for (results, 0..) |result, i| {
                std.debug.print("  \"{s}\"", .{result});
                if (i < results.len - 1) {
                    std.debug.print(",\n", .{});
                } else {
                    std.debug.print("\n", .{});
                }
            }
            std.debug.print("]\n", .{});
        },
        .csv => {
            for (results) |result| {
                std.debug.print("\"{s}\"\n", .{result});
            }
        },
    }
    _ = allocator;
}

fn batchGenerate(allocator: std.mem.Allocator, args: []const []const u8) !void {
    if (args.len < 3) {
        std.debug.print("Usage: faker batch <count> --template <file>\n", .{});
        std.debug.print("Example: faker batch 100 --template user.json\n", .{});
        return;
    }

    const count = try std.fmt.parseInt(usize, args[2], 10);

    // Parse options
    var template_file: ?[]const u8 = null;
    var seed: ?u64 = null;

    var i: usize = 3;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--template") or std.mem.eql(u8, arg, "-t")) {
            if (i + 1 < args.len) {
                template_file = args[i + 1];
                i += 1;
            }
        } else if (std.mem.eql(u8, arg, "--seed") or std.mem.eql(u8, arg, "-s")) {
            if (i + 1 < args.len) {
                seed = try std.fmt.parseInt(u64, args[i + 1], 10);
                i += 1;
            }
        }
    }

    if (template_file == null) {
        std.debug.print("Error: --template <file> is required\n", .{});
        return;
    }

    // For now, just show a message about template support
    std.debug.print("Batch generation with templates is coming soon!\n", .{});
    std.debug.print("Count: {}\n", .{count});
    std.debug.print("Template: {s}\n", .{template_file.?});
    if (seed) |s| {
        std.debug.print("Seed: {}\n", .{s});
    }

    _ = allocator;
}

fn getLocale(code: []const u8) ?*const @import("faker.zig").LocaleDefinition {
    // English variants
    if (std.mem.eql(u8, code, "en")) return &locales.en;
    if (std.mem.eql(u8, code, "en_US")) return &locales.en_US;
    if (std.mem.eql(u8, code, "en_GB")) return &locales.en_GB;
    if (std.mem.eql(u8, code, "en_AU")) return &locales.en_AU;
    if (std.mem.eql(u8, code, "en_CA")) return &locales.en_CA;
    if (std.mem.eql(u8, code, "en_IN")) return &locales.en_IN;

    // Spanish variants
    if (std.mem.eql(u8, code, "es")) return &locales.es;
    if (std.mem.eql(u8, code, "es_ES")) return &locales.es_ES;
    if (std.mem.eql(u8, code, "es_MX")) return &locales.es_MX;

    // German variants
    if (std.mem.eql(u8, code, "de")) return &locales.de;
    if (std.mem.eql(u8, code, "de_DE")) return &locales.de_DE;
    if (std.mem.eql(u8, code, "de_AT")) return &locales.de_AT;
    if (std.mem.eql(u8, code, "de_CH")) return &locales.de_CH;

    // French variants
    if (std.mem.eql(u8, code, "fr")) return &locales.fr;
    if (std.mem.eql(u8, code, "fr_FR")) return &locales.fr_FR;
    if (std.mem.eql(u8, code, "fr_CA")) return &locales.fr_CA;
    if (std.mem.eql(u8, code, "fr_BE")) return &locales.fr_BE;
    if (std.mem.eql(u8, code, "fr_CH")) return &locales.fr_CH;

    // Portuguese variants
    if (std.mem.eql(u8, code, "pt")) return &locales.pt;
    if (std.mem.eql(u8, code, "pt_BR")) return &locales.pt_BR;
    if (std.mem.eql(u8, code, "pt_PT")) return &locales.pt_PT;

    // Chinese variants
    if (std.mem.eql(u8, code, "zh")) return &locales.zh;
    if (std.mem.eql(u8, code, "zh_CN")) return &locales.zh_CN;
    if (std.mem.eql(u8, code, "zh_TW")) return &locales.zh_TW;

    // Other base locales
    if (std.mem.eql(u8, code, "it")) return &locales.it;
    if (std.mem.eql(u8, code, "ja")) return &locales.ja;
    if (std.mem.eql(u8, code, "ko")) return &locales.ko;
    if (std.mem.eql(u8, code, "nl")) return &locales.nl;
    if (std.mem.eql(u8, code, "uk")) return &locales.uk;

    return null;
}
