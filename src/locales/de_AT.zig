// German (Austria) locale
const locale = @import("../locale.zig");
const de_base = @import("de.zig").de;

// Austrian cities
const city_at = [_][]const u8{
    "Wien", "Graz", "Linz", "Salzburg", "Innsbruck",
    "Klagenfurt", "Villach", "Wels", "St. Pölten", "Dornbirn",
    "Steyr", "Wiener Neustadt", "Feldkirch", "Bregenz", "Leonding",
    "Klosterneuburg", "Baden", "Wolfsberg", "Leoben", "Krems",
    "Traun", "Amstetten", "Kapfenberg", "Mödling", "Lustenau",
};

// Austrian states (Bundesländer)
const state_at = [_][]const u8{
    "Wien", "Niederösterreich", "Oberösterreich", "Steiermark",
    "Tirol", "Kärnten", "Salzburg", "Vorarlberg", "Burgenland",
};

const state_abbr_at = [_][]const u8{
    "W", "NÖ", "OÖ", "ST", "T", "K", "S", "V", "B",
};

// Austrian postal code format (4-digit)
const postal_code_format_at = [_][]const u8{
    "####",
};

// Austrian phone formats
const phone_format_at = [_][]const u8{
    "+43 ### ######",
    "0### ######",
    "+43 # ########",
};

pub const de_AT: locale.LocaleDefinition = .{
    .title = "Deutsch (Österreich)",
    .person = de_base.person,
    .address = locale.AddressLocale{
        .street_name = de_base.address.street_name,
        .city = &city_at,
        .state = &state_at,
        .state_abbr = &state_abbr_at,
        .country = &[_][]const u8{"Österreich"},
        .postal_code_format = &postal_code_format_at,
        .building_number = de_base.address.building_number,
        .direction = de_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = de_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".at", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "gmx.at", "aon.at", "chello.at" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_at,
    },
    .food = de_base.food,
    .animal = de_base.animal,
};
