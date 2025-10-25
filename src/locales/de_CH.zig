// German (Switzerland) locale
const locale = @import("../locale.zig");
const de_base = @import("de.zig").de;

// Swiss cities (German-speaking regions)
const city_ch = [_][]const u8{
    "Zürich", "Basel", "Bern", "Luzern", "St. Gallen",
    "Winterthur", "Thun", "Köniz", "Schaffhausen", "Chur",
    "Fribourg", "Aarau", "Zug", "Solothurn", "Baden",
    "Wil", "Kreuzlingen", "Rapperswil-Jona", "Wetzikon", "Uster",
    "Emmen", "Dietikon", "Riehen", "Kriens", "Allschwil",
};

// Swiss cantons (German names)
const state_ch = [_][]const u8{
    "Zürich", "Bern", "Luzern", "Uri", "Schwyz",
    "Obwalden", "Nidwalden", "Glarus", "Zug", "Fribourg",
    "Solothurn", "Basel-Stadt", "Basel-Landschaft", "Schaffhausen", "Appenzell Ausserrhoden",
    "Appenzell Innerrhoden", "St. Gallen", "Graubünden", "Aargau", "Thurgau",
    "Tessin", "Waadt", "Wallis", "Neuenburg", "Genf", "Jura",
};

const state_abbr_ch = [_][]const u8{
    "ZH", "BE", "LU", "UR", "SZ", "OW", "NW", "GL", "ZG", "FR",
    "SO", "BS", "BL", "SH", "AR", "AI", "SG", "GR", "AG", "TG",
    "TI", "VD", "VS", "NE", "GE", "JU",
};

// Swiss postal code format (4-digit)
const postal_code_format_ch = [_][]const u8{
    "####",
};

// Swiss phone formats
const phone_format_ch = [_][]const u8{
    "+41 ## ### ## ##",
    "0## ### ## ##",
    "+41 ### ### ###",
};

pub const de_CH: locale.LocaleDefinition = .{
    .title = "Deutsch (Schweiz)",
    .person = de_base.person,
    .address = locale.AddressLocale{
        .street_name = de_base.address.street_name,
        .city = &city_ch,
        .state = &state_ch,
        .state_abbr = &state_abbr_ch,
        .country = &[_][]const u8{"Schweiz"},
        .postal_code_format = &postal_code_format_ch,
        .building_number = de_base.address.building_number,
        .direction = de_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = de_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ch", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "bluewin.ch", "gmx.ch", "hotmail.ch" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_ch,
    },
    .food = de_base.food,
    .animal = de_base.animal,
};
