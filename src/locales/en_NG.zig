// English (Nigeria) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

const city_ng = [_][]const u8{
    "Lagos", "Kano", "Ibadan", "Abuja", "Port Harcourt",
    "Benin City", "Maiduguri", "Zaria", "Aba", "Jos",
    "Ilorin", "Oyo", "Enugu", "Abeokuta", "Kaduna",
};

pub const en_NG: locale.LocaleDefinition = .{
    .title = "English (Nigeria)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_ng,
        .state = &[_][]const u8{"Lagos", "Kano", "Kaduna", "Oyo", "Rivers", "Anambra"},
        .state_abbr = &[_][]const u8{"LA", "KN", "KD", "OY", "RI", "AN"},
        .country = &[_][]const u8{"Nigeria"},
        .postal_code_format = &[_][]const u8{"######"},
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ng", ".com.ng", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.com", "hotmail.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+234 ### ### ####", "0### ### ####" },
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
