// Portuguese (Portugal) locale
const locale = @import("../locale.zig");
const pt_base = @import("pt.zig").pt;

const city_pt = [_][]const u8{
    "Lisboa", "Porto", "Vila Nova de Gaia", "Amadora", "Braga",
    "Funchal", "Coimbra", "Setúbal", "Almada", "Agualva-Cacém",
    "Queluz", "Rio Tinto", "Corroios", "Barreiro", "Montijo",
};

pub const pt_PT: locale.LocaleDefinition = .{
    .title = "Português (Portugal)",
    .person = pt_base.person,
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{
            "Rua Garrett", "Avenida da Liberdade", "Praça do Comércio",
            "Rua de Santa Catarina", "Rua Augusta", "Largo do Rato",
        },
        .city = &city_pt,
        .state = &[_][]const u8{"Lisboa", "Porto", "Braga", "Setúbal", "Coimbra", "Faro", "Aveiro", "Évora"},
        .state_abbr = &[_][]const u8{"LIS", "POR", "BRA", "SET", "COI", "FAR", "AVE", "EVO"},
        .country = &[_][]const u8{"Portugal"},
        .postal_code_format = &[_][]const u8{"####-###"},
        .building_number = pt_base.address.building_number,
        .direction = pt_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = pt_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".pt", ".com.pt", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "sapo.pt", "hotmail.com", "outlook.pt" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+351 ### ### ###", "### ### ###" },
    },
    .food = pt_base.food,
    .animal = pt_base.animal,
};
