// English (Australia) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

// Australian cities
const city_au = [_][]const u8{
    "Sydney", "Melbourne", "Brisbane", "Perth", "Adelaide",
    "Gold Coast", "Newcastle", "Canberra", "Sunshine Coast", "Wollongong",
    "Hobart", "Geelong", "Townsville", "Cairns", "Darwin",
    "Toowoomba", "Ballarat", "Bendigo", "Albury", "Launceston",
    "Mackay", "Rockhampton", "Bunbury", "Bundaberg", "Wagga Wagga",
};

// Australian states and territories
const state_au = [_][]const u8{
    "New South Wales", "Victoria", "Queensland", "Western Australia",
    "South Australia", "Tasmania", "Australian Capital Territory", "Northern Territory",
};

const state_abbr_au = [_][]const u8{
    "NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT",
};

// Australian phone formats
const phone_format_au = [_][]const u8{
    "+61 # #### ####",
    "0# #### ####",
    "(0#) #### ####",
};

// Australian postal code format
const postal_code_format_au = [_][]const u8{
    "####",  // 4-digit Australian postcode
};

// Australian street names
const street_name_au = [_][]const u8{
    "George Street", "Elizabeth Street", "Pitt Street", "Castlereagh Street",
    "King Street", "Queen Street", "Collins Street", "Bourke Street",
    "Flinders Street", "Swanston Street", "Chapel Street", "Brunswick Street",
    "Oxford Street", "William Street", "Victoria Street", "Albert Street",
};

pub const en_AU: locale.LocaleDefinition = .{
    .title = "English (Australia)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = &street_name_au,
        .city = &city_au,
        .state = &state_au,
        .state_abbr = &state_abbr_au,
        .country = &[_][]const u8{"Australia"},
        .postal_code_format = &postal_code_format_au,
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".au", ".com.au", ".net.au", ".org.au", ".edu.au" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "outlook.com", "yahoo.com.au", "bigpond.com", "optusnet.com.au" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format_au,
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
