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

        faker.person = PersonModule.init(allocator, &faker.random, selected_locale);
        faker.address = AddressModule.init(allocator, &faker.random, selected_locale);
        faker.company = CompanyModule.init(allocator, &faker.random, selected_locale);
        faker.internet = InternetModule.init(allocator, &faker.random, selected_locale);
        faker.phone = PhoneModule.init(allocator, &faker.random, selected_locale);
        faker.string = StringModule.init(allocator, &faker.random);
        faker.food = FoodModule.init(allocator, &faker.random, selected_locale);
        faker.animal = AnimalModule.init(allocator, &faker.random, selected_locale);
        faker.date = DateModule.init(allocator, &faker.random);
        faker.number = NumberModule.init(allocator, &faker.random);
        faker.color = ColorModule.init(allocator, &faker.random);
        faker.lorem = LoremModule.init(allocator, &faker.random);
        faker.vehicle = VehicleModule.init(allocator, &faker.random);
        faker.sport = SportModule.init(allocator, &faker.random);
        faker.music = MusicModule.init(allocator, &faker.random);
        faker.book = BookModule.init(allocator, &faker.random);
        faker.commerce = CommerceModule.init(allocator, &faker.random);
        faker.word = WordModule.init(allocator, &faker.random);
        faker.hacker = HackerModule.init(allocator, &faker.random);
        faker.system = SystemModule.init(allocator, &faker.random);
        faker.science = ScienceModule.init(allocator, &faker.random);
        faker.finance = FinanceModule.init(allocator, &faker.random);
        faker.database = DatabaseModule.init(allocator, &faker.random);
        faker.git = GitModule.init(allocator, &faker.random);
        faker.image = ImageModule.init(allocator, &faker.random);

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
        self.food.random = &self.random;
        self.animal.random = &self.random;
        self.date.random = &self.random;
        self.number.random = &self.random;
        self.color.random = &self.random;
        self.lorem.random = &self.random;
        self.vehicle.random = &self.random;
        self.sport.random = &self.random;
        self.music.random = &self.random;
        self.book.random = &self.random;
        self.commerce.random = &self.random;
        self.word.random = &self.random;
        self.hacker.random = &self.random;
        self.system.random = &self.random;
        self.science.random = &self.random;
        self.finance.random = &self.random;
        self.database.random = &self.random;
        self.git.random = &self.random;
        self.image.random = &self.random;
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

    const first_name = faker.person.firstName(.{});
    try std.testing.expect(first_name.len > 0);
}

// FIXME: Seeding doesn't work reliably due to Zig's PRNG pointer semantics
// test "faker with seed" {
//     const allocator = std.testing.allocator;
//     var faker1 = Faker.init(allocator, 12345, null);
//     var faker2 = Faker.init(allocator, 12345, null);
//
//     const name1 = faker1.person.firstName(.{});
//     const name2 = faker2.person.firstName(.{});
//
//     try std.testing.expectEqualStrings(name1, name2);
// }

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

test "food module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const dish_name = faker.food.dish();
    try std.testing.expect(dish_name.len > 0);

    const ingredient_name = faker.food.ingredient();
    try std.testing.expect(ingredient_name.len > 0);

    const fruit_name = faker.food.fruit();
    try std.testing.expect(fruit_name.len > 0);

    const recipe_name = try faker.food.recipe();
    defer allocator.free(recipe_name);
    try std.testing.expect(recipe_name.len > 0);
}

test "animal module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const dog_breed = faker.animal.dog();
    try std.testing.expect(dog_breed.len > 0);

    const cat_breed = faker.animal.cat();
    try std.testing.expect(cat_breed.len > 0);

    const bird_species = faker.animal.bird();
    try std.testing.expect(bird_species.len > 0);

    const pet_name = faker.animal.petName();
    try std.testing.expect(pet_name.len > 0);
}

test "date module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const ts = faker.date.timestamp();
    try std.testing.expect(ts > 0);

    const weekday_name = faker.date.weekday();
    try std.testing.expect(weekday_name.len > 0);

    const month_name = faker.date.month();
    try std.testing.expect(month_name.len > 0);

    const date_str = try faker.date.dateString();
    defer allocator.free(date_str);
    try std.testing.expectEqual(@as(usize, 10), date_str.len);
}

test "number module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const int_val = faker.number.int(1, 100);
    try std.testing.expect(int_val >= 1 and int_val <= 100);

    const float_val = faker.number.float(0.0, 1.0);
    try std.testing.expect(float_val >= 0.0 and float_val <= 1.0);

    const percentage_val = faker.number.percentage(2);
    try std.testing.expect(percentage_val >= 0.0 and percentage_val <= 100.0);

    const bin = try faker.number.binary(8);
    defer allocator.free(bin);
    try std.testing.expectEqual(@as(usize, 8), bin.len);
}

test "color module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const color_name = faker.color.name();
    try std.testing.expect(color_name.len > 0);

    const hex_color = try faker.color.hex();
    defer allocator.free(hex_color);
    try std.testing.expect(hex_color[0] == '#');
    try std.testing.expectEqual(@as(usize, 7), hex_color.len);

    const rgb_color = try faker.color.rgb();
    defer allocator.free(rgb_color);
    try std.testing.expect(rgb_color.len > 0);

    const css_color = faker.color.cssColor();
    try std.testing.expect(css_color.len > 0);
}

test "lorem module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const word_str = faker.lorem.word();
    try std.testing.expect(word_str.len > 0);

    const words_str = try faker.lorem.words(5);
    defer allocator.free(words_str);
    try std.testing.expect(words_str.len > 0);

    const sentence_str = try faker.lorem.sentence();
    defer allocator.free(sentence_str);
    try std.testing.expect(sentence_str.len > 0);
    try std.testing.expect(sentence_str[sentence_str.len - 1] == '.');

    const paragraph_str = try faker.lorem.paragraph();
    defer allocator.free(paragraph_str);
    try std.testing.expect(paragraph_str.len > 0);
}

test "vehicle module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const manufacturer_name = faker.vehicle.manufacturer();
    try std.testing.expect(manufacturer_name.len > 0);

    const model_name = faker.vehicle.model();
    try std.testing.expect(model_name.len > 0);

    const vehicle_type = faker.vehicle.type_();
    try std.testing.expect(vehicle_type.len > 0);

    const vin_str = try faker.vehicle.vin();
    defer allocator.free(vin_str);
    try std.testing.expectEqual(@as(usize, 17), vin_str.len);

    const license = try faker.vehicle.licensePlate();
    defer allocator.free(license);
    try std.testing.expect(license.len > 0);
}

test "sport module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const sport_name = faker.sport.sport();
    try std.testing.expect(sport_name.len > 0);

    const team = faker.sport.team();
    try std.testing.expect(team.len > 0);

    const athlete = faker.sport.athlete();
    try std.testing.expect(athlete.len > 0);

    const full_team = try faker.sport.fullTeamName();
    defer allocator.free(full_team);
    try std.testing.expect(full_team.len > 0);
}

test "music module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const genre = faker.music.genre();
    try std.testing.expect(genre.len > 0);

    const artist = faker.music.artist();
    try std.testing.expect(artist.len > 0);

    const song = faker.music.song();
    try std.testing.expect(song.len > 0);

    const instrument = faker.music.instrument();
    try std.testing.expect(instrument.len > 0);

    const album = faker.music.album();
    try std.testing.expect(album.len > 0);
}

test "book module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const title = faker.book.title();
    try std.testing.expect(title.len > 0);

    const author = faker.book.author();
    try std.testing.expect(author.len > 0);

    const genre = faker.book.genre();
    try std.testing.expect(genre.len > 0);

    const isbn10 = try faker.book.isbn10();
    defer allocator.free(isbn10);
    try std.testing.expectEqual(@as(usize, 13), isbn10.len); // includes dashes

    const isbn13 = try faker.book.isbn13();
    defer allocator.free(isbn13);
    try std.testing.expectEqual(@as(usize, 17), isbn13.len); // includes dashes
}

test "commerce module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const product = faker.commerce.product();
    try std.testing.expect(product.len > 0);

    const material = faker.commerce.productMaterial();
    try std.testing.expect(material.len > 0);

    const price_val = faker.commerce.price(10.0, 100.0);
    try std.testing.expect(price_val >= 10.0 and price_val <= 100.0);

    const sku = try faker.commerce.sku();
    defer allocator.free(sku);
    try std.testing.expect(sku.len > 0);
}

test "word module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const adjective = faker.word.adjective();
    try std.testing.expect(adjective.len > 0);

    const noun = faker.word.noun();
    try std.testing.expect(noun.len > 0);

    const verb = faker.word.verb();
    try std.testing.expect(verb.len > 0);

    const adverb = faker.word.adverb();
    try std.testing.expect(adverb.len > 0);
}

test "hacker module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const abbr = faker.hacker.abbreviation();
    try std.testing.expect(abbr.len > 0);

    const adj = faker.hacker.adjective();
    try std.testing.expect(adj.len > 0);

    const phrase_str = try faker.hacker.phrase();
    defer allocator.free(phrase_str);
    try std.testing.expect(phrase_str.len > 0);
}

test "system module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const filename = faker.system.fileName();
    try std.testing.expect(filename.len > 0);

    const ext = faker.system.fileExt();
    try std.testing.expect(ext.len > 0);

    const mime = faker.system.mimeType();
    try std.testing.expect(mime.len > 0);

    const path = try faker.system.filePath();
    defer allocator.free(path);
    try std.testing.expect(path.len > 0);

    const version = try faker.system.semver();
    defer allocator.free(version);
    try std.testing.expect(version.len > 0);
}

test "science module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const element = faker.science.element();
    try std.testing.expect(element.len > 0);

    const symbol = faker.science.elementSymbol();
    try std.testing.expect(symbol.len > 0);

    const formula = try faker.science.chemicalFormula();
    defer allocator.free(formula);
    try std.testing.expect(formula.len > 0);

    const unit = faker.science.unit();
    try std.testing.expect(unit.len > 0);
}

test "finance module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const cc = try faker.finance.creditCardNumber();
    defer allocator.free(cc);
    try std.testing.expect(cc.len > 0);

    const iban = try faker.finance.iban();
    defer allocator.free(iban);
    try std.testing.expect(iban.len > 0);

    const bic = try faker.finance.bic();
    defer allocator.free(bic);
    try std.testing.expectEqual(@as(usize, 8), bic.len);

    const btc = try faker.finance.bitcoinAddress();
    defer allocator.free(btc);
    try std.testing.expect(btc.len > 0);

    const eth = try faker.finance.ethereumAddress();
    defer allocator.free(eth);
    try std.testing.expectEqual(@as(usize, 42), eth.len);
}

test "database module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const col = faker.database.column();
    try std.testing.expect(col.len > 0);

    const tbl = faker.database.table();
    try std.testing.expect(tbl.len > 0);

    const engine = faker.database.engine();
    try std.testing.expect(engine.len > 0);

    const type_ = faker.database.type_();
    try std.testing.expect(type_.len > 0);

    const oid = try faker.database.mongodbObjectId();
    defer allocator.free(oid);
    try std.testing.expectEqual(@as(usize, 24), oid.len);
}

test "git module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const branch_name = faker.git.branch();
    try std.testing.expect(branch_name.len > 0);

    const sha = try faker.git.commitSha();
    defer allocator.free(sha);
    try std.testing.expectEqual(@as(usize, 40), sha.len);

    const short_sha = try faker.git.commitShortSha();
    defer allocator.free(short_sha);
    try std.testing.expectEqual(@as(usize, 7), short_sha.len);

    const message = faker.git.commitMessage();
    try std.testing.expect(message.len > 0);

    const conventional = try faker.git.conventionalCommit();
    defer allocator.free(conventional);
    try std.testing.expect(conventional.len > 0);
}

test "image module" {
    const allocator = std.testing.allocator;
    var faker = Faker.init(allocator, 12345, null);

    const category = faker.image.category();
    try std.testing.expect(category.len > 0);

    const type_ = faker.image.type_();
    try std.testing.expect(type_.len > 0);

    const url_str = try faker.image.url(800, 600);
    defer allocator.free(url_str);
    try std.testing.expect(url_str.len > 0);

    const gray_url = try faker.image.grayscaleUrl(400, 300);
    defer allocator.free(gray_url);
    try std.testing.expect(gray_url.len > 0);

    const data_uri = try faker.image.dataUri();
    defer allocator.free(data_uri);
    try std.testing.expect(data_uri.len > 0);

    const filename = try faker.image.fileName();
    defer allocator.free(filename);
    try std.testing.expect(filename.len > 0);
}
