// Dutch (Nederlands) locale - Minimal version
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

pub const nl: locale.LocaleDefinition = .{
    .title = "Nederlands",
    .person = locale.PersonLocale{
        .first_name_male = &[_][]const u8{ "Jan", "Pieter", "Hendrik", "Willem", "Johannes", "Cornelis", "Gerrit", "Jacobus", "Adrianus", "Simon" },
        .first_name_female = &[_][]const u8{ "Maria", "Anna", "Johanna", "Hendrika", "Wilhelmina", "Petronella", "Elisabeth", "Geertruida", "Cornelia", "Catharina" },
        .first_name_neutral = &[_][]const u8{},
        .last_name = &[_][]const u8{ "de Jong", "Jansen", "de Vries", "van den Berg", "van Dijk", "Bakker", "Janssen", "Visser", "Smit", "Meijer", "de Boer", "Mulder", "de Groot", "Bos", "Vos" },
        .prefix = &[_][]const u8{ "Dhr.", "Mevr.", "Dr.", "Prof." },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "Mannelijk", "Vrouwelijk", "Niet-binair" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{ "Hoofdstraat", "Kerkstraat", "Schoolstraat", "Dorpsstraat", "Molenstraat" },
        .city = &[_][]const u8{ "Amsterdam", "Rotterdam", "Den Haag", "Utrecht", "Eindhoven", "Tilburg", "Groningen", "Almere", "Breda", "Nijmegen" },
        .state = &[_][]const u8{ "Noord-Holland", "Zuid-Holland", "Utrecht", "Gelderland", "Limburg", "Noord-Brabant", "Zeeland", "Groningen", "Friesland", "Drenthe", "Overijssel", "Flevoland" },
        .state_abbr = &[_][]const u8{ "NH", "ZH", "UT", "GLD", "LB", "NB", "ZL", "GR", "FR", "DR", "OV", "FL" },
        .country = &[_][]const u8{ "Nederland", "België", "Duitsland", "Frankrijk" },
        .postal_code_format = &[_][]const u8{ "#### ??" },
        .building_number = &[_][]const u8{ "#", "##", "###" },
        .direction = &[_][]const u8{ "Noord", "Zuid", "Oost", "West" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".nl", ".be", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "hotmail.nl", "ziggo.nl", "live.nl" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+31 ## ### ####", "### ### ####" },
    },
    .food = en.food,
    .animal = en.animal,
};
