// Zulu (South Africa) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

// Common Zulu first names
const first_name_male = [_][]const u8{
    "Bongani", "Mandla", "Sipho", "Thabo", "Nkosinathi",
    "Senzo", "Bheki", "Mlungisi", "Vusi", "Sabelo",
    "Mthunzi", "Sibusiso", "Jabu", "Andile", "Nhlanhla",
};

const first_name_female = [_][]const u8{
    "Nandi", "Thandi", "Zanele", "Nomsa", "Nokuthula",
    "Sindisiwe", "Busisiwe", "Zinhle", "Ntombifuthi", "Zama",
    "Thandeka", "Lindiwe", "Nombuso", "Nompumelelo", "Ntombi",
};

const last_name = [_][]const u8{
    "Dlamini", "Nkosi", "Khumalo", "Mthethwa", "Zulu",
    "Ngubane", "Makhanya", "Ndlovu", "Cele", "Ntuli",
    "Buthelezi", "Xulu", "Gumede", "Mazibuko", "Sithole",
    "Shange", "Mdletshe", "Mbatha", "Ngcobo", "Mkhize",
};

// South African cities (Zulu names where applicable)
const city_za = [_][]const u8{
    "eThekwini", "eGoli", "iKapa", "Tshwane", "iBhayi",
    "Mangaung", "Nelspruit", "Polokwane", "Kimberley", "Pietermaritzburg",
    "Durban", "Richards Bay", "Port Shepstone", "Empangeni", "Ladysmith",
};

// South African provinces (some with Zulu names)
const state_za = [_][]const u8{
    "Gauteng", "Western Cape", "KwaZulu-Natal", "Eastern Cape", "Limpopo",
    "Mpumalanga", "North West", "Free State", "Northern Cape",
};

const state_abbr_za = [_][]const u8{
    "GP", "WC", "KZN", "EC", "LP", "MP", "NW", "FS", "NC",
};

pub const zu_ZA: locale.LocaleDefinition = .{
    .title = "isiZulu (Ningizimu Afrika)",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &[_][]const u8{ "Mnu.", "Nkk.", "uDkt.", "uSolw." },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "Owesilisa", "Owesifazane", "Okungemuva" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{
            "Umgwaqo Omkhulu", "Isitrato SaseGoli", "Indlela", "Isitrato",
            "Umgwaqo", "Indawo", "I-Avenue", "I-Boulevard", "Isitaladi", "Umgwaqo Wesikole",
        },
        .city = &city_za,
        .state = &state_za,
        .state_abbr = &state_abbr_za,
        .country = &[_][]const u8{"Ningizimu Afrika"},
        .postal_code_format = &[_][]const u8{"####"},
        .building_number = &[_][]const u8{ "#", "##", "###" },
        .direction = &[_][]const u8{ "Enyakatho", "Eningizimu", "Empumalanga", "Entshonalanga" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".co.za", ".za", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.co.za", "webmail.co.za", "mweb.co.za" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+27 ## ### ####", "0## ### ####" },
    },
    .food = en.food,
    .animal = en.animal,
};
