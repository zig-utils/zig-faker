// Spanish (Spain) locale
// Regional variant for Spain with Spain-specific data

const locale = @import("../locale.zig");
const es_base = @import("es.zig").es;

// Spain-specific cities
const city_es = [_][]const u8{
    "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza",
    "Málaga", "Murcia", "Palma de Mallorca", "Bilbao", "Alicante",
    "Córdoba", "Valladolid", "Vigo", "Gijón", "L'Hospitalet de Llobregat",
    "Granada", "Vitoria", "Elche", "Oviedo", "Badalona",
    "Cartagena", "Terrassa", "Jerez de la Frontera", "Sabadell", "Móstoles",
    "Santa Cruz de Tenerife", "Pamplona", "Almería", "Fuenlabrada", "Leganés",
    "San Sebastián", "Burgos", "Santander", "Castellón de la Plana", "Alcalá de Henares",
    "La Coruña", "Logroño", "Badajoz", "Salamanca", "Huelva",
};

// Spain autonomous communities
const state_es = [_][]const u8{
    "Andalucía", "Aragón", "Asturias", "Baleares", "Canarias",
    "Cantabria", "Castilla-La Mancha", "Castilla y León", "Cataluña", "Extremadura",
    "Galicia", "La Rioja", "Madrid", "Murcia", "Navarra",
    "País Vasco", "Valencia", "Ceuta", "Melilla",
};

const state_abbr_es = [_][]const u8{
    "AN", "AR", "AS", "IB", "CN", "CB", "CM", "CL", "CT", "EX",
    "GA", "RI", "MD", "MU", "NC", "PV", "VC", "CE", "ML",
};

// Spain phone formats
const phone_format_es = [_][]const u8{
    "+34 ### ### ###",
    "### ### ###",
    "9## ## ## ##",
    "6## ## ## ##",  // Mobile
    "7## ## ## ##",  // Mobile
};

// Spain postal code format
const postal_code_format_es = [_][]const u8{
    "#####",  // 5-digit Spanish postal code
};

// Spain-specific street types
const street_name_es = [_][]const u8{
    "Calle Mayor", "Plaza Mayor", "Avenida Principal", "Paseo de la Castellana",
    "Gran Vía", "Calle Alcalá", "Paseo de Gracia", "Rambla de Cataluña",
    "Calle Serrano", "Avenida Diagonal", "Calle Goya", "Plaza de España",
    "Calle Velázquez", "Paseo del Prado", "Avenida de América", "Calle Princesa",
    "Plaza de Castilla", "Calle Arenal", "Plaza de Cibeles", "Puerta del Sol",
};

// Export Spain locale variant
pub const es_ES: locale.LocaleDefinition = .{
    .title = "Español (España)",
    .person = es_base.person,
    .address = locale.AddressLocale{
        .street_name = &street_name_es,
        .city = &city_es,
        .state = &state_es,
        .state_abbr = &state_abbr_es,
        .country = &[_][]const u8{"España"},
        .postal_code_format = &postal_code_format_es,
        .building_number = es_base.address.building_number,
        .direction = es_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = es_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".es", ".com.es", ".org.es", ".net", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.es", "yahoo.es", "outlook.es", "hotmail.com",
            "correo.es", "ya.com", "terra.es", "ono.com",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_es,
    },
    .food = es_base.food,
    .animal = es_base.animal,
};
