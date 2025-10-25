// English (United Kingdom) locale
// This is a regional variant that extends the base 'en' locale
// with UK-specific data

const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

// UK counties (administrative divisions)
const county_gb = [_][]const u8{
    "England",      "Scotland",     "Wales",        "Northern Ireland",
    "Greater London", "West Midlands", "Greater Manchester", "West Yorkshire",
    "Merseyside",   "South Yorkshire", "Tyne and Wear", "Lancashire",
    "Kent",         "Essex",        "Hampshire",    "Surrey",
    "Hertfordshire", "Berkshire",   "Oxfordshire",  "Devon",
    "Cornwall",     "Somerset",     "Dorset",       "Wiltshire",
    "Gloucestershire", "Cambridgeshire", "Norfolk",  "Suffolk",
    "Leicestershire", "Nottinghamshire", "Derbyshire", "Staffordshire",
};

const county_abbr_gb = [_][]const u8{
    "ENG", "SCT", "WLS", "NIR", "LDN", "WMD", "GTM", "WYK",
    "MER", "SYK", "TWR", "LAN", "KEN", "ESS", "HAM", "SUR",
    "HRT", "BRK", "OXF", "DEV", "CON", "SOM", "DOR", "WIL",
    "GLO", "CAM", "NOR", "SUF", "LEI", "NOT", "DBY", "STS",
};

// UK-specific phone formats
const phone_format_gb = [_][]const u8{
    "0#### ######",
    "0#### ### ###",
    "+44 #### ######",
    "+44 ## #### ####",
    "07### ######",  // Mobile
};

// UK-specific postal code formats
const postal_code_format_gb = [_][]const u8{
    "??# #??",   // e.g., SW1A 1AA
    "??## #??",  // e.g., EC1A 1BB
    "?# #??",    // e.g., M1 1AA
    "?## #??",   // e.g., B33 8TH
};

// UK-specific cities
const city_gb = [_][]const u8{
    "London",       "Birmingham",   "Manchester",   "Glasgow",      "Liverpool",
    "Edinburgh",    "Leeds",        "Sheffield",    "Bristol",      "Cardiff",
    "Belfast",      "Newcastle",    "Nottingham",   "Leicester",    "Coventry",
    "Bradford",     "Hull",         "Plymouth",     "Stoke-on-Trent", "Wolverhampton",
    "Derby",        "Southampton",  "Portsmouth",   "Brighton",     "Reading",
    "Northampton",  "Luton",        "Milton Keynes", "Swindon",     "Warrington",
    "Bournemouth",  "Norwich",      "Peterborough", "Oxford",       "Cambridge",
    "York",         "Bath",         "Canterbury",   "Exeter",       "Chester",
};

// Export the GB locale variant
pub const en_GB: locale.LocaleDefinition = .{
    .title = "English (United Kingdom)",
    .person = en_base.person, // Use base English names
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_gb, // UK-specific cities
        .state = &county_gb, // UK counties
        .state_abbr = &county_abbr_gb, // UK county abbreviations
        .country = &[_][]const u8{"United Kingdom"},
        .postal_code_format = &postal_code_format_gb, // UK postcodes
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company, // Use base English company data
    .internet = en_base.internet, // Use base English internet data
    .phone = locale.PhoneLocale{
        .format = &phone_format_gb, // UK phone formats
    },
    .food = en_base.food, // Use base English food data
    .animal = en_base.animal, // Use base English animal data
};
