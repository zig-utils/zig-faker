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
const FoodModule = @import("modules/food.zig").Food;
const AnimalModule = @import("modules/animal.zig").Animal;
const DateModule = @import("modules/date.zig").DateModule;
const NumberModule = @import("modules/number.zig").NumberModule;
const ColorModule = @import("modules/color.zig").Color;
const LoremModule = @import("modules/lorem.zig").Lorem;
const VehicleModule = @import("modules/vehicle.zig").Vehicle;
const SportModule = @import("modules/sport.zig").Sport;
const MusicModule = @import("modules/music.zig").Music;
const BookModule = @import("modules/book.zig").Book;
const CommerceModule = @import("modules/commerce.zig").Commerce;
const WordModule = @import("modules/word.zig").Word;
const HackerModule = @import("modules/hacker.zig").Hacker;
const SystemModule = @import("modules/system.zig").System;
const ScienceModule = @import("modules/science.zig").Science;
const FinanceModule = @import("modules/finance.zig").Finance;
const DatabaseModule = @import("modules/database.zig").Database;
const GitModule = @import("modules/git.zig").Git;
const ImageModule = @import("modules/image.zig").Image;

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
    food: FoodModule,
    animal: AnimalModule,
    date: DateModule,
    number: NumberModule,
    color: ColorModule,
    lorem: LoremModule,
    vehicle: VehicleModule,
    sport: SportModule,
    music: MusicModule,
    book: BookModule,
    commerce: CommerceModule,
    word: WordModule,
    hacker: HackerModule,
    system: SystemModule,
    science: ScienceModule,
    finance: FinanceModule,
    database: DatabaseModule,
    git: GitModule,
    image: ImageModule,

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
            .food = undefined,
            .animal = undefined,
            .date = undefined,
            .number = undefined,
            .color = undefined,
            .lorem = undefined,
            .vehicle = undefined,
            .sport = undefined,
            .music = undefined,
            .book = undefined,
            .commerce = undefined,
            .word = undefined,
            .hacker = undefined,
            .system = undefined,
            .science = undefined,
            .finance = undefined,
            .database = undefined,
            .git = undefined,
            .image = undefined,
        };

        // Initialize modules (no longer need to pass random pointer)
        faker.person = PersonModule.init(allocator, selected_locale);
        faker.address = AddressModule.init(allocator, selected_locale);
        faker.company = CompanyModule.init(allocator, selected_locale);
        faker.internet = InternetModule.init(allocator, selected_locale);
        faker.phone = PhoneModule.init(allocator, selected_locale);
        faker.string = StringModule.init(allocator);
        faker.food = FoodModule.init(allocator, selected_locale);
        faker.animal = AnimalModule.init(allocator, selected_locale);
        faker.date = DateModule.init(allocator);
        faker.number = NumberModule.init(allocator);
        faker.color = ColorModule.init(allocator);
        faker.lorem = LoremModule.init(allocator);
        faker.vehicle = VehicleModule.init(allocator);
        faker.sport = SportModule.init(allocator);
        faker.music = MusicModule.init(allocator);
        faker.book = BookModule.init(allocator);
        faker.commerce = CommerceModule.init(allocator);
        faker.word = WordModule.init(allocator);
        faker.hacker = HackerModule.init(allocator);
        faker.system = SystemModule.init(allocator);
        faker.science = ScienceModule.init(allocator);
        faker.finance = FinanceModule.init(allocator);
        faker.database = DatabaseModule.init(allocator);
        faker.git = GitModule.init(allocator);
        faker.image = ImageModule.init(allocator);

        return faker;
    }

    /// Set a new seed for reproducible generation
    pub fn seed(self: *Faker, seed_value: u64) void {
        self.random.prng = std.Random.DefaultPrng.init(seed_value);
        self.random.seed_value = seed_value;
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
        self.food.locale = new_locale;
        self.animal.locale = new_locale;
    }
};

// Tests
test "faker initialization" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const first_name = faker.person.firstName(&faker.random, .{});
    try std.testing.expect(first_name.len > 0);
}

test "random module seeding" {
    var rng1 = Random.init(12345);
    var rng2 = Random.init(12345);

    const val1a = rng1.int(0, 100);
    const val2a = rng2.int(0, 100);
    try std.testing.expectEqual(val1a, val2a);

    const val1b = rng1.int(0, 100);
    const val2b = rng2.int(0, 100);
    try std.testing.expectEqual(val1b, val2b);

    const val1c = rng1.int(0, 100);
    const val2c = rng2.int(0, 100);
    try std.testing.expectEqual(val1c, val2c);
}

test "faker with seed" {
    const allocator = std.testing.allocator;
    var faker1 = Faker.init(allocator, 12345, null);
    var faker2 = Faker.init(allocator, 12345, null);

    // First test: same seed should produce same sequence
    const int1a = faker1.random.int(0, 100);
    const int2a = faker2.random.int(0, 100);
    try std.testing.expectEqual(int1a, int2a);

    const int1b = faker1.random.int(0, 100);
    const int2b = faker2.random.int(0, 100);
    try std.testing.expectEqual(int1b, int2b);

    // Test with explicit gender to eliminate one source of randomness
    const name1 = faker1.person.firstName(&faker1.random, .{ .gender = Gender.female });
    const name2 = faker2.person.firstName(&faker2.random, .{ .gender = Gender.female });

    try std.testing.expectEqualStrings(name1, name2);
}

test "person module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const first = faker.person.firstName(&faker.random, .{});
    try std.testing.expect(first.len > 0);

    const last = faker.person.lastName(&faker.random);
    try std.testing.expect(last.len > 0);

    const full = try faker.person.fullName(&faker.random, .{});
    defer allocator.free(full);
    try std.testing.expect(full.len > 0);

    const job = faker.person.jobTitle(&faker.random);
    try std.testing.expect(job.len > 0);
}

test "address module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const city_name = faker.address.city(&faker.random);
    try std.testing.expect(city_name.len > 0);

    const state_name = faker.address.state(&faker.random);
    try std.testing.expect(state_name.len > 0);

    const zip = try faker.address.postalCode(&faker.random);
    defer allocator.free(zip);
    try std.testing.expect(zip.len > 0);

    const street = try faker.address.streetAddress(&faker.random, .{});
    defer allocator.free(street);
    try std.testing.expect(street.len > 0);
}

test "company module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const company_name = try faker.company.name(&faker.random);
    defer allocator.free(company_name);
    try std.testing.expect(company_name.len > 0);

    const industry_name = faker.company.industry(&faker.random);
    try std.testing.expect(industry_name.len > 0);

    const phrase = try faker.company.catchPhrase(&faker.random);
    defer allocator.free(phrase);
    try std.testing.expect(phrase.len > 0);
}

test "internet module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const email_addr = try faker.internet.email(&faker.random);
    defer allocator.free(email_addr);
    try std.testing.expect(email_addr.len > 0);
    try std.testing.expect(std.mem.indexOf(u8, email_addr, "@") != null);

    const url_str = try faker.internet.url(&faker.random);
    defer allocator.free(url_str);
    try std.testing.expect(url_str.len > 0);

    const user = try faker.internet.username(&faker.random);
    defer allocator.free(user);
    try std.testing.expect(user.len > 0);
}

test "phone module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const phone_number = try faker.phone.phoneNumber(&faker.random);
    defer allocator.free(phone_number);
    try std.testing.expect(phone_number.len > 0);
}

test "string module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const uuid_str = try faker.string.uuid(&faker.random);
    defer allocator.free(uuid_str);
    try std.testing.expectEqual(@as(usize, 36), uuid_str.len);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[8]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[13]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[18]);
    try std.testing.expectEqual(@as(u8, '-'), uuid_str[23]);

    const nano = try faker.string.nanoid(&faker.random, 21);
    defer allocator.free(nano);
    try std.testing.expectEqual(@as(usize, 21), nano.len);

    const alphanum = try faker.string.alphanumeric(&faker.random, 10);
    defer allocator.free(alphanum);
    try std.testing.expectEqual(@as(usize, 10), alphanum.len);
}

test "food module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const dish_name = faker.food.dish(&faker.random);
    try std.testing.expect(dish_name.len > 0);

    const ingredient_name = faker.food.ingredient(&faker.random);
    try std.testing.expect(ingredient_name.len > 0);

    const fruit_name = faker.food.fruit(&faker.random);
    try std.testing.expect(fruit_name.len > 0);

    const recipe_name = try faker.food.recipe(&faker.random);
    defer allocator.free(recipe_name);
    try std.testing.expect(recipe_name.len > 0);
}

test "animal module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const dog_breed = faker.animal.dog(&faker.random);
    try std.testing.expect(dog_breed.len > 0);

    const cat_breed = faker.animal.cat(&faker.random);
    try std.testing.expect(cat_breed.len > 0);

    const bird_species = faker.animal.bird(&faker.random);
    try std.testing.expect(bird_species.len > 0);

    const pet_name = faker.animal.petName(&faker.random);
    try std.testing.expect(pet_name.len > 0);
}

test "date module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const ts = faker.date.timestamp(&faker.random);
    try std.testing.expect(ts > 0);

    const weekday_name = faker.date.weekday(&faker.random);
    try std.testing.expect(weekday_name.len > 0);

    const month_name = faker.date.month(&faker.random);
    try std.testing.expect(month_name.len > 0);

    const date_str = try faker.date.dateString(&faker.random);
    defer allocator.free(date_str);
    try std.testing.expect(date_str.len >= 10); // Format: YYYY-MM-DD (10 chars minimum)
}

test "number module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const int_val = faker.number.int(&faker.random, 1, 100);
    try std.testing.expect(int_val >= 1 and int_val <= 100);

    const float_val = faker.number.float(&faker.random, 0.0, 1.0);
    try std.testing.expect(float_val >= 0.0 and float_val <= 1.0);

    const percentage_val = faker.number.percentage(&faker.random, 2);
    try std.testing.expect(percentage_val >= 0.0 and percentage_val <= 100.0);

    const bin = try faker.number.binary(&faker.random, 8);
    defer allocator.free(bin);
    try std.testing.expectEqual(@as(usize, 8), bin.len);
}

test "color module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const color_name = faker.color.name(&faker.random);
    try std.testing.expect(color_name.len > 0);

    const hex_color = try faker.color.hex(&faker.random);
    defer allocator.free(hex_color);
    try std.testing.expect(hex_color[0] == '#');
    try std.testing.expectEqual(@as(usize, 7), hex_color.len);

    const rgb_color = try faker.color.rgb(&faker.random);
    defer allocator.free(rgb_color);
    try std.testing.expect(rgb_color.len > 0);

    const css_color = faker.color.cssColor(&faker.random);
    try std.testing.expect(css_color.len > 0);
}

test "lorem module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const word_str = faker.lorem.word(&faker.random);
    try std.testing.expect(word_str.len > 0);

    const words_str = try faker.lorem.words(&faker.random, 5);
    defer allocator.free(words_str);
    try std.testing.expect(words_str.len > 0);

    const sentence_str = try faker.lorem.sentence(&faker.random);
    defer allocator.free(sentence_str);
    try std.testing.expect(sentence_str.len > 0);
    try std.testing.expect(sentence_str[sentence_str.len - 1] == '.');

    const paragraph_str = try faker.lorem.paragraph(&faker.random);
    defer allocator.free(paragraph_str);
    try std.testing.expect(paragraph_str.len > 0);
}

test "vehicle module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const manufacturer_name = faker.vehicle.manufacturer(&faker.random);
    try std.testing.expect(manufacturer_name.len > 0);

    const model_name = faker.vehicle.model(&faker.random);
    try std.testing.expect(model_name.len > 0);

    const vehicle_type = faker.vehicle.type_(&faker.random);
    try std.testing.expect(vehicle_type.len > 0);

    const vin_str = try faker.vehicle.vin(&faker.random);
    defer allocator.free(vin_str);
    try std.testing.expectEqual(@as(usize, 17), vin_str.len);

    const license = try faker.vehicle.licensePlate(&faker.random);
    defer allocator.free(license);
    try std.testing.expect(license.len > 0);
}

test "sport module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const sport_name = faker.sport.sport(&faker.random);
    try std.testing.expect(sport_name.len > 0);

    const team = faker.sport.team(&faker.random);
    try std.testing.expect(team.len > 0);

    const athlete = faker.sport.athlete(&faker.random);
    try std.testing.expect(athlete.len > 0);

    const full_team = try faker.sport.fullTeamName(&faker.random);
    defer allocator.free(full_team);
    try std.testing.expect(full_team.len > 0);
}

test "music module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const genre = faker.music.genre(&faker.random);
    try std.testing.expect(genre.len > 0);

    const artist = faker.music.artist(&faker.random);
    try std.testing.expect(artist.len > 0);

    const song = faker.music.song(&faker.random);
    try std.testing.expect(song.len > 0);

    const instrument = faker.music.instrument(&faker.random);
    try std.testing.expect(instrument.len > 0);

    const album = faker.music.album(&faker.random);
    try std.testing.expect(album.len > 0);
}

test "book module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const title = faker.book.title(&faker.random);
    try std.testing.expect(title.len > 0);

    const author = faker.book.author(&faker.random);
    try std.testing.expect(author.len > 0);

    const genre = faker.book.genre(&faker.random);
    try std.testing.expect(genre.len > 0);

    const isbn10 = try faker.book.isbn10(&faker.random);
    defer allocator.free(isbn10);
    try std.testing.expectEqual(@as(usize, 10), isbn10.len); // 10 digits

    const isbn13 = try faker.book.isbn13(&faker.random);
    defer allocator.free(isbn13);
    try std.testing.expectEqual(@as(usize, 14), isbn13.len); // ###-########## format
}

test "commerce module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const product = faker.commerce.product(&faker.random);
    try std.testing.expect(product.len > 0);

    const material = faker.commerce.productMaterial(&faker.random);
    try std.testing.expect(material.len > 0);

    const price_val = faker.commerce.price(&faker.random, 10.0, 100.0);
    try std.testing.expect(price_val >= 10.0 and price_val <= 100.0);

    const sku = try faker.commerce.sku(&faker.random);
    defer allocator.free(sku);
    try std.testing.expect(sku.len > 0);
}

test "word module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const adjective = faker.word.adjective(&faker.random);
    try std.testing.expect(adjective.len > 0);

    const noun = faker.word.noun(&faker.random);
    try std.testing.expect(noun.len > 0);

    const verb = faker.word.verb(&faker.random);
    try std.testing.expect(verb.len > 0);

    const adverb = faker.word.adverb(&faker.random);
    try std.testing.expect(adverb.len > 0);
}

test "hacker module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const abbr = faker.hacker.abbreviation(&faker.random);
    try std.testing.expect(abbr.len > 0);

    const adj = faker.hacker.adjective(&faker.random);
    try std.testing.expect(adj.len > 0);

    const phrase_str = try faker.hacker.phrase(&faker.random);
    defer allocator.free(phrase_str);
    try std.testing.expect(phrase_str.len > 0);
}

test "system module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const filename = faker.system.fileName(&faker.random);
    try std.testing.expect(filename.len > 0);

    const ext = faker.system.fileExt(&faker.random);
    try std.testing.expect(ext.len > 0);

    const mime = faker.system.mimeType(&faker.random);
    try std.testing.expect(mime.len > 0);

    const path = try faker.system.filePath(&faker.random);
    defer allocator.free(path);
    try std.testing.expect(path.len > 0);

    const version = try faker.system.semver(&faker.random);
    defer allocator.free(version);
    try std.testing.expect(version.len > 0);
}

test "science module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const element = faker.science.element(&faker.random);
    try std.testing.expect(element.len > 0);

    const symbol = faker.science.elementSymbol(&faker.random);
    try std.testing.expect(symbol.len > 0);

    const formula = try faker.science.chemicalFormula(&faker.random);
    defer allocator.free(formula);
    try std.testing.expect(formula.len > 0);

    const unit = faker.science.unit(&faker.random);
    try std.testing.expect(unit.len > 0);
}

test "finance module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const cc = try faker.finance.creditCardNumber(&faker.random);
    defer allocator.free(cc);
    try std.testing.expect(cc.len > 0);

    const iban = try faker.finance.iban(&faker.random);
    defer allocator.free(iban);
    try std.testing.expect(iban.len > 0);

    const bic = try faker.finance.bic(&faker.random);
    defer allocator.free(bic);
    try std.testing.expectEqual(@as(usize, 8), bic.len);

    const btc = try faker.finance.bitcoinAddress(&faker.random);
    defer allocator.free(btc);
    try std.testing.expect(btc.len > 0);

    const eth = try faker.finance.ethereumAddress(&faker.random);
    defer allocator.free(eth);
    try std.testing.expectEqual(@as(usize, 42), eth.len);
}

test "database module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const col = faker.database.column(&faker.random);
    try std.testing.expect(col.len > 0);

    const tbl = faker.database.table(&faker.random);
    try std.testing.expect(tbl.len > 0);

    const engine = faker.database.engine(&faker.random);
    try std.testing.expect(engine.len > 0);

    const type_ = faker.database.type_(&faker.random);
    try std.testing.expect(type_.len > 0);

    const oid = try faker.database.mongodbObjectId(&faker.random);
    defer allocator.free(oid);
    try std.testing.expectEqual(@as(usize, 24), oid.len);
}

test "git module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const branch_name = faker.git.branch(&faker.random);
    try std.testing.expect(branch_name.len > 0);

    const sha = try faker.git.commitSha(&faker.random);
    defer allocator.free(sha);
    try std.testing.expectEqual(@as(usize, 40), sha.len);

    const short_sha = try faker.git.commitShortSha(&faker.random);
    defer allocator.free(short_sha);
    try std.testing.expectEqual(@as(usize, 7), short_sha.len);

    const message = faker.git.commitMessage(&faker.random);
    try std.testing.expect(message.len > 0);

    const conventional = try faker.git.conventionalCommit(&faker.random);
    defer allocator.free(conventional);
    try std.testing.expect(conventional.len > 0);
}

test "image module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const category = faker.image.category(&faker.random);
    try std.testing.expect(category.len > 0);

    const type_ = faker.image.type_(&faker.random);
    try std.testing.expect(type_.len > 0);

    const url_str = try faker.image.url(&faker.random, 800, 600);
    defer allocator.free(url_str);
    try std.testing.expect(url_str.len > 0);

    const gray_url = try faker.image.grayscaleUrl(&faker.random, 400, 300);
    defer allocator.free(gray_url);
    try std.testing.expect(gray_url.len > 0);

    const data_uri = try faker.image.dataUri(&faker.random);
    defer allocator.free(data_uri);
    try std.testing.expect(data_uri.len > 0);

    const filename = try faker.image.fileName(&faker.random);
    defer allocator.free(filename);
    try std.testing.expect(filename.len > 0);
}
