// French (France) locale
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_FR: locale.LocaleDefinition = .{
    .title = "Français (France)",
    .person = fr_base.person,
    .address = locale.AddressLocale{
        .street_name = fr_base.address.street_name,
        .city = fr_base.address.city,
        .state = fr_base.address.state,
        .state_abbr = fr_base.address.state_abbr,
        .country = &[_][]const u8{"France"},
        .postal_code_format = &[_][]const u8{"#####"},
        .building_number = fr_base.address.building_number,
        .direction = fr_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = fr_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".fr", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "hotmail.fr", "yahoo.fr", "orange.fr", "free.fr" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+33 # ## ## ## ##", "0# ## ## ## ##" },
    },
    .food = fr_base.food,
    .animal = fr_base.animal,
};
