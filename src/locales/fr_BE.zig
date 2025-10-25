// French (Belgium) locale
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_BE: locale.LocaleDefinition = .{
    .title = "Français (Belgique)",
    .person = fr_base.person,
    .address = locale.AddressLocale{
        .street_name = fr_base.address.street_name,
        .city = &[_][]const u8{"Bruxelles", "Anvers", "Gand", "Charleroi", "Liège", "Bruges", "Namur", "Louvain", "Mons"},
        .state = &[_][]const u8{"Bruxelles", "Flandre", "Wallonie"},
        .state_abbr = &[_][]const u8{"BRU", "VLG", "WAL"},
        .country = &[_][]const u8{"Belgique"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = fr_base.address.building_number,
        .direction = fr_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = fr_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".be", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "hotmail.be", "skynet.be", "outlook.be" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+32 ### ## ## ##", "0### ## ## ##" },
    },
    .food = fr_base.food,
    .animal = fr_base.animal,
};
