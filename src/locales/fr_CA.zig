// French (Canada) locale
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

const city_ca = [_][]const u8{
    "Montréal", "Québec", "Laval", "Gatineau", "Longueuil",
    "Sherbrooke", "Saguenay", "Lévis", "Trois-Rivières", "Terrebonne",
};

pub const fr_CA: locale.LocaleDefinition = .{
    .title = "Français (Canada)",
    .person = fr_base.person,
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{
            "Rue Saint-Denis", "Boulevard René-Lévesque", "Rue Sainte-Catherine",
            "Avenue du Mont-Royal", "Rue Sherbrooke", "Boulevard Saint-Laurent",
        },
        .city = &city_ca,
        .state = &[_][]const u8{"Québec", "Ontario", "Manitoba", "Saskatchewan", "Alberta", "Colombie-Britannique"},
        .state_abbr = &[_][]const u8{"QC", "ON", "MB", "SK", "AB", "BC"},
        .country = &[_][]const u8{"Canada"},
        .postal_code_format = &[_][]const u8{"?#? #?#"},
        .building_number = fr_base.address.building_number,
        .direction = fr_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = fr_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ca", ".qc.ca", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "enligne", "numérique" },
        .free_email = &[_][]const u8{ "gmail.com", "hotmail.ca", "yahoo.ca", "outlook.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+1 (###) ###-####", "(###) ###-####" },
    },
    .food = fr_base.food,
    .animal = fr_base.animal,
};
