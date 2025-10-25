// English (Canada) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

// Canadian cities
const city_ca = [_][]const u8{
    "Toronto", "Montreal", "Vancouver", "Calgary", "Edmonton",
    "Ottawa", "Winnipeg", "Quebec City", "Hamilton", "Kitchener",
    "London", "Victoria", "Halifax", "Oshawa", "Windsor",
    "Saskatoon", "Regina", "St. John's", "Barrie", "Kelowna",
    "Abbotsford", "Kingston", "Trois-Rivières", "Sherbrooke", "Guelph",
};

// Canadian provinces and territories
const state_ca = [_][]const u8{
    "Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
    "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island",
    "Quebec", "Saskatchewan", "Yukon",
};

const state_abbr_ca = [_][]const u8{
    "AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT",
};

// Canadian phone formats
const phone_format_ca = [_][]const u8{
    "+1 (###) ###-####",
    "(###) ###-####",
    "###-###-####",
};

// Canadian postal code format
const postal_code_format_ca = [_][]const u8{
    "?#? #?#",  // Canadian postal code format (e.g., K1A 0B1)
};

pub const en_CA: locale.LocaleDefinition = .{
    .title = "English (Canada)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_ca,
        .state = &state_ca,
        .state_abbr = &state_abbr_ca,
        .country = &[_][]const u8{"Canada"},
        .postal_code_format = &postal_code_format_ca,
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ca", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "outlook.com", "yahoo.ca", "hotmail.ca", "rogers.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_ca,
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
