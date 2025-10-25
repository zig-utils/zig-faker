// English (India) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

const city_in = [_][]const u8{
    "Mumbai", "Delhi", "Bangalore", "Hyderabad", "Ahmedabad",
    "Chennai", "Kolkata", "Pune", "Jaipur", "Surat",
    "Lucknow", "Kanpur", "Nagpur", "Indore", "Thane",
    "Bhopal", "Visakhapatnam", "Pimpri-Chinchwad", "Patna", "Vadodara",
    "Ghaziabad", "Ludhiana", "Agra", "Nashik", "Faridabad",
};

const state_in = [_][]const u8{
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
    "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
    "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
    "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
    "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
    "Uttar Pradesh", "Uttarakhand", "West Bengal",
};

const state_abbr_in = [_][]const u8{
    "AP", "AR", "AS", "BR", "CG", "GA", "GJ", "HR", "HP", "JH",
    "KA", "KL", "MP", "MH", "MN", "ML", "MZ", "NL", "OD", "PB",
    "RJ", "SK", "TN", "TS", "TR", "UP", "UK", "WB",
};

pub const en_IN: locale.LocaleDefinition = .{
    .title = "English (India)",
    .person = en_base.person,
    .address = locale.AddressLocale{
        .street_name = en_base.address.street_name,
        .city = &city_in,
        .state = &state_in,
        .state_abbr = &state_abbr_in,
        .country = &[_][]const u8{"India"},
        .postal_code_format = &[_][]const u8{"######"},
        .building_number = en_base.address.building_number,
        .direction = en_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = en_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".in", ".co.in", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.co.in", "rediffmail.com", "outlook.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+91 ##### #####", "+91 ## #### ####" },
    },
    .food = en_base.food,
    .animal = en_base.animal,
};
