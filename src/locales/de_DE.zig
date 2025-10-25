// German (Germany) locale
const locale = @import("../locale.zig");
const de_base = @import("de.zig").de;

// German phone formats (specific to Germany)
const phone_format_de = [_][]const u8{
    "+49 ### #######",
    "0### #######",
    "+49 ## ########",
    "(0###) #######",
};

pub const de_DE: locale.LocaleDefinition = .{
    .title = "Deutsch (Deutschland)",
    .person = de_base.person,
    .address = locale.AddressLocale{
        .street_name = de_base.address.street_name,
        .city = de_base.address.city,
        .state = de_base.address.state,
        .state_abbr = de_base.address.state_abbr,
        .country = &[_][]const u8{"Deutschland"},
        .postal_code_format = de_base.address.postal_code_format,
        .building_number = de_base.address.building_number,
        .direction = de_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = de_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".de", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "gmx.de", "web.de", "t-online.de", "hotmail.de" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_de,
    },
    .food = de_base.food,
    .animal = de_base.animal,
};
