// English (Ghana) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

const city_gh = [_][]const u8{
    "Accra", "Kumasi", "Tamale", "Takoradi", "Ashaiman",
    "Sunyani", "Cape Coast", "Obuasi", "Teshie", "Tema",
};

pub const en_GH: locale.LocaleDefinition = .{
    .title = "English (Ghana)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_gh,
        .state = &[_][]const u8{"Greater Accra", "Ashanti", "Western", "Eastern", "Central", "Northern"},
        .state_abbr = &[_][]const u8{"GA", "AH", "WP", "EP", "CP", "NP"},
        .country = &[_][]const u8{"Ghana"},
        .postal_code_format = &[_][]const u8{"??-####-####"},
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".gh", ".com.gh", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.com", "hotmail.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+233 ### ### ###", "0### ### ###" },
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
