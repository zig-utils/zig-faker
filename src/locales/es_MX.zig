// Spanish (Mexico) locale
// Regional variant for Mexico with Mexico-specific data

const locale = @import("../locale.zig");
const es_base = @import("es.zig").es;

// Mexico-specific cities
const city_mx = [_][]const u8{
    "Ciudad de México", "Guadalajara", "Monterrey", "Puebla", "Tijuana",
    "León", "Juárez", "Torreón", "Querétaro", "Mérida",
    "San Luis Potosí", "Aguascalientes", "Mexicali", "Hermosillo", "Saltillo",
    "Culiacán", "Chihuahua", "Morelia", "Toluca", "Cancún",
    "Veracruz", "Acapulco", "Mazatlán", "Oaxaca", "Tampico",
    "Reynosa", "Tuxtla Gutiérrez", "Durango", "Cuernavaca", "Pachuca",
    "Ensenada", "Tlaxcala", "Celaya", "Irapuato", "Playa del Carmen",
    "Villahermosa", "Xalapa", "Ciudad Obregón", "Uruapan", "Los Cabos",
};

// Mexican states
const state_mx = [_][]const u8{
    "Aguascalientes", "Baja California", "Baja California Sur", "Campeche", "Chiapas",
    "Chihuahua", "Coahuila", "Colima", "Durango", "Guanajuato",
    "Guerrero", "Hidalgo", "Jalisco", "México", "Michoacán",
    "Morelos", "Nayarit", "Nuevo León", "Oaxaca", "Puebla",
    "Querétaro", "Quintana Roo", "San Luis Potosí", "Sinaloa", "Sonora",
    "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatán",
    "Zacatecas", "Ciudad de México",
};

const state_abbr_mx = [_][]const u8{
    "AG", "BC", "BS", "CM", "CS", "CH", "CO", "CL", "DG", "GT",
    "GR", "HG", "JA", "EM", "MI", "MO", "NA", "NL", "OA", "PU",
    "QT", "QR", "SL", "SI", "SO", "TB", "TM", "TL", "VE", "YU",
    "ZA", "CM",
};

// Mexico phone formats
const phone_format_mx = [_][]const u8{
    "+52 ## #### ####",
    "+52 1 ## #### ####",  // Mobile
    "(###) ###-####",
    "##-####-####",
    "### ### ####",
};

// Mexico postal code format (C.P. - Código Postal)
const postal_code_format_mx = [_][]const u8{
    "#####",  // 5-digit Mexican postal code
};

// Mexico-specific street types
const street_name_mx = [_][]const u8{
    "Avenida Reforma", "Paseo de la Reforma", "Avenida Insurgentes", "Eje Central",
    "Avenida Juárez", "Calle Madero", "Avenida Revolución", "Calzada de Tlalpan",
    "Avenida Universidad", "Periférico Sur", "Circuito Interior", "Viaducto Miguel Alemán",
    "Avenida Constituyentes", "Paseo de las Palmas", "Avenida Chapultepec", "Polanco",
    "Calle Hidalgo", "Avenida Morelos", "Boulevard López Mateos", "Avenida Cuauhtémoc",
};

// Export Mexico locale variant
pub const es_MX: locale.LocaleDefinition = .{
    .title = "Español (México)",
    .person = es_base.person,
    .address = locale.AddressLocale{
        .street_name = &street_name_mx,
        .city = &city_mx,
        .state = &state_mx,
        .state_abbr = &state_abbr_mx,
        .country = &[_][]const u8{"México"},
        .postal_code_format = &postal_code_format_mx,
        .building_number = es_base.address.building_number,
        .direction = es_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = es_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".mx", ".com.mx", ".gob.mx", ".org.mx", ".net", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.com", "yahoo.com.mx", "outlook.com", "prodigy.net.mx",
            "live.com.mx", "msn.com", "latinmail.com", "terra.com.mx",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_mx,
    },
    .food = es_base.food,
    .animal = es_base.animal,
};
