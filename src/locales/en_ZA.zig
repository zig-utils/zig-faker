// English (South Africa) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

const city_za = [_][]const u8{
    "Johannesburg", "Cape Town", "Durban", "Pretoria", "Port Elizabeth",
    "Bloemfontein", "East London", "Pietermaritzburg", "Benoni", "Tembisa",
    "Vereeniging", "Boksburg", "Welkom", "Newcastle", "Krugersdorp",
};

const state_za = [_][]const u8{
    "Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", "Limpopo",
    "Mpumalanga", "Northern Cape", "North West", "Western Cape",
};

pub const en_ZA: locale.LocaleDefinition = .{
    .title = "English (South Africa)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_za,
        .state = &state_za,
        .state_abbr = &[_][]const u8{ "EC", "FS", "GP", "KZN", "LP", "MP", "NC", "NW", "WC" },
        .country = &[_][]const u8{"South Africa"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".za", ".co.za", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.com", "webmail.co.za", "mweb.co.za" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+27 ## ### ####", "0## ### ####" },
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
