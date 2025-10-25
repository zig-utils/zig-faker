// Portuguese (Mozambique) locale
const locale = @import("../locale.zig");
const pt_base = @import("pt.zig").pt;

pub const pt_MZ: locale.LocaleDefinition = .{
    .title = "Português (Moçambique)",
    .person = pt_base.person,
    .address = locale.AddressLocale{
        .street_name = pt_base.address.street_name,
        .city = &[_][]const u8{"Maputo", "Matola", "Nampula", "Beira", "Chimoio", "Nacala", "Quelimane", "Tete"},
        .state = &[_][]const u8{"Maputo", "Gaza", "Inhambane", "Sofala", "Manica", "Tete", "Zambézia", "Nampula"},
        .state_abbr = &[_][]const u8{"MPM", "GAZ", "INH", "SOF", "MAN", "TET", "ZAM", "NAM"},
        .country = &[_][]const u8{"Moçambique"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = pt_base.address.building_number,
        .direction = pt_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = pt_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".mz", ".co.mz", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.com", "hotmail.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+258 ## ### ####", "## ### ####" },
    },
    .food = pt_base.food,
    .animal = pt_base.animal,
};
