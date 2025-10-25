// Afrikaans (South Africa) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

// Common Afrikaans first names
const first_name_male = [_][]const u8{
    "Andries", "Christiaan", "Cornelis", "Danie", "Frans",
    "Gideon", "Hennie", "Jan", "Johannes", "Kobus",
    "Marius", "Petrus", "Pieter", "Stefanus", "Willem",
};

const first_name_female = [_][]const u8{
    "Annelie", "Annelize", "Elsa", "Hannelie", "Hester",
    "Ilse", "Karla", "Lida", "Magda", "Marthie",
    "Rina", "Sarie", "Susanna", "Tersia", "Wilhelmina",
};

const last_name = [_][]const u8{
    "Van der Merwe", "Van Wyk", "Pretorius", "Nel", "Botha",
    "Du Plessis", "Visser", "Venter", "De Villiers", "Smit",
    "Fourie", "Barnard", "Marais", "Steyn", "Van Zyl",
    "Kruger", "Coetzee", "Meyer", "Le Roux", "Brink",
};

// South African cities
const city_za = [_][]const u8{
    "Johannesburg", "Kaapstad", "Durban", "Pretoria", "Port Elizabeth",
    "Bloemfontein", "Nelspruit", "Polokwane", "Kimberley", "Upington",
    "George", "Stellenbosch", "Paarl", "Worcester", "Oudtshoorn",
};

// South African provinces
const state_za = [_][]const u8{
    "Gauteng", "Wes-Kaap", "KwaZulu-Natal", "Oos-Kaap", "Limpopo",
    "Mpumalanga", "Noord-Wes", "Vrystaat", "Noord-Kaap",
};

const state_abbr_za = [_][]const u8{
    "GP", "WC", "KZN", "EC", "LP", "MP", "NW", "FS", "NC",
};

pub const af_ZA: locale.LocaleDefinition = .{
    .title = "Afrikaans (Suid-Afrika)",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &[_][]const u8{ "Mnr.", "Mev.", "Dr.", "Prof." },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "Manlik", "Vroulik", "Nie-binêr" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{
            "Kerkstraat", "Hoofstraat", "Voorstraat", "Kerkweg", "Langstraat",
            "Dorpstraat", "Marktstraat", "Parkstraat", "Stasiestraat", "Waterstraat",
        },
        .city = &city_za,
        .state = &state_za,
        .state_abbr = &state_abbr_za,
        .country = &[_][]const u8{"Suid-Afrika"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = &[_][]const u8{ "#", "##", "###" },
        .direction = &[_][]const u8{ "Noord", "Suid", "Oos", "Wes" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".co.za", ".za", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "aanlyn", "digitaal" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.co.za", "webmail.co.za", "mweb.co.za" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+27 ## ### ####", "0## ### ####" },
    },
    .food = en.food,
    .animal = en.animal,
};
