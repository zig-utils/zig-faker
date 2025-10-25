// English (Ireland) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

const city_ie = [_][]const u8{
    "Dublin", "Cork", "Limerick", "Galway", "Waterford",
    "Drogheda", "Dundalk", "Swords", "Bray", "Navan",
    "Ennis", "Kilkenny", "Carlow", "Tralee", "Newbridge",
};

const state_ie = [_][]const u8{
    "Carlow", "Cavan", "Clare", "Cork", "Donegal", "Dublin",
    "Galway", "Kerry", "Kildare", "Kilkenny", "Laois", "Leitrim",
    "Limerick", "Longford", "Louth", "Mayo", "Meath", "Monaghan",
    "Offaly", "Roscommon", "Sligo", "Tipperary", "Waterford",
    "Westmeath", "Wexford", "Wicklow",
};

pub const en_IE: locale.LocaleDefinition = .{
    .title = "English (Ireland)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_ie,
        .state = &state_ie,
        .state_abbr = &state_ie,
        .country = &[_][]const u8{"Ireland"},
        .postal_code_format = &[_][]const u8{"??? ????"},
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ie", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.ie", "eircom.net", "outlook.ie" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+353 ## ### ####", "0## ### ####" },
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
