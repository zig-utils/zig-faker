// French (Switzerland) locale
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_CH: locale.LocaleDefinition = .{
    .title = "Français (Suisse)",
    .person = fr_base.person,
    .address = locale.AddressLocale{
        .street_name = fr_base.address.street_name,
        .city = &[_][]const u8{"Genève", "Lausanne", "Neuchâtel", "Fribourg", "Sion", "Bienne", "Yverdon"},
        .state = &[_][]const u8{"Genève", "Vaud", "Neuchâtel", "Fribourg", "Valais", "Jura"},
        .state_abbr = &[_][]const u8{"GE", "VD", "NE", "FR", "VS", "JU"},
        .country = &[_][]const u8{"Suisse"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = fr_base.address.building_number,
        .direction = fr_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = fr_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ch", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "bluewin.ch", "hotmail.ch" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+41 ## ### ## ##", "0## ### ## ##" },
    },
    .food = fr_base.food,
    .animal = fr_base.animal,
};
