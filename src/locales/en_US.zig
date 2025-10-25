// English (United States) locale
// This is a regional variant that extends the base 'en' locale
// with US-specific data where appropriate

const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

// US-specific state data (already in base, but showing how variants work)
const state_us = [_][]const u8{
    "Alabama",      "Alaska",       "Arizona",      "Arkansas",     "California",
    "Colorado",     "Connecticut",  "Delaware",     "Florida",      "Georgia",
    "Hawaii",       "Idaho",        "Illinois",     "Indiana",      "Iowa",
    "Kansas",       "Kentucky",     "Louisiana",    "Maine",        "Maryland",
    "Massachusetts", "Michigan",    "Minnesota",    "Mississippi",  "Missouri",
    "Montana",      "Nebraska",     "Nevada",       "New Hampshire", "New Jersey",
    "New Mexico",   "New York",     "North Carolina", "North Dakota", "Ohio",
    "Oklahoma",     "Oregon",       "Pennsylvania", "Rhode Island", "South Carolina",
    "South Dakota", "Tennessee",    "Texas",        "Utah",         "Vermont",
    "Virginia",     "Washington",   "West Virginia", "Wisconsin",   "Wyoming",
};

const state_abbr_us = [_][]const u8{
    "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
    "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
    "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
    "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
    "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY",
};

// US-specific phone formats
const phone_format_us = [_][]const u8{
    "(###) ###-####",
    "###-###-####",
    "### ### ####",
    "+1 ### ### ####",
    "1-###-###-####",
};

// US-specific postal code (ZIP code) formats
const postal_code_format_us = [_][]const u8{
    "#####",
    "#####-####", // ZIP+4
};

// US-specific cities (top population centers)
const city_us = [_][]const u8{
    "New York",      "Los Angeles",   "Chicago",       "Houston",       "Phoenix",
    "Philadelphia",  "San Antonio",   "San Diego",     "Dallas",        "San Jose",
    "Austin",        "Jacksonville",  "Fort Worth",    "Columbus",      "Charlotte",
    "San Francisco", "Indianapolis",  "Seattle",       "Denver",        "Washington",
    "Boston",        "Nashville",     "Baltimore",     "Portland",      "Las Vegas",
    "Detroit",       "Memphis",       "Louisville",    "Milwaukee",     "Albuquerque",
    "Tucson",        "Fresno",        "Sacramento",    "Kansas City",   "Atlanta",
    "Miami",         "Oakland",       "Minneapolis",   "Tulsa",         "Cleveland",
    "Wichita",       "New Orleans",   "Arlington",     "Tampa",         "Bakersfield",
    "Aurora",        "Honolulu",      "Anaheim",       "Santa Ana",     "Corpus Christi",
};

// Export the US locale variant
pub const en_US: locale.LocaleDefinition = .{
    .title = "English (United States)",
    .person = en_base.person, // Use base English names
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_us, // US-specific cities
        .state = &state_us, // US states
        .state_abbr = &state_abbr_us, // US state abbreviations
        .country = &[_][]const u8{"United States"},
        .postal_code_format = &postal_code_format_us, // US ZIP codes
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company, // Use base English company data
    .internet = en_base.internet, // Use base English internet data
    .phone = locale.PhoneLocale{
        .format = &phone_format_us, // US phone formats
    },
    .food = en_base.food, // Use base English food data
    .animal = en_base.animal, // Use base English animal data
};
