// Italian (Italiano) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

const first_name_male = [_][]const u8{
    "Alessandro", "Andrea", "Angelo", "Antonio", "Carlo",
    "Claudio", "Daniele", "Davide", "Emanuele", "Enrico",
    "Fabio", "Federico", "Francesco", "Gabriele", "Giacomo",
    "Gianluca", "Giorgio", "Giovanni", "Giuseppe", "Leonardo",
    "Lorenzo", "Luca", "Luigi", "Marco", "Massimo",
    "Matteo", "Mattia", "Michele", "Nicola", "Paolo",
    "Pietro", "Riccardo", "Roberto", "Salvatore", "Simone",
    "Stefano", "Tommaso", "Valentino", "Vincenzo", "Vittorio",
};

const first_name_female = [_][]const u8{
    "Alessandra", "Alice", "Anna", "Antonella", "Beatrice",
    "Camilla", "Carla", "Chiara", "Claudia", "Cristina",
    "Daniela", "Elena", "Elisa", "Elisabetta", "Federica",
    "Francesca", "Gabriella", "Giada", "Giorgia", "Giulia",
    "Ilaria", "Laura", "Lucia", "Luisa", "Maria",
    "Marta", "Martina", "Michela", "Monica", "Paola",
    "Roberta", "Sara", "Serena", "Silvia", "Simona",
    "Sofia", "Stefania", "Teresa", "Valentina", "Veronica",
};

const last_name = [_][]const u8{
    "Rossi", "Russo", "Ferrari", "Esposito", "Bianchi",
    "Romano", "Colombo", "Ricci", "Marino", "Greco",
    "Bruno", "Gallo", "Conti", "De Luca", "Mancini",
    "Costa", "Giordano", "Rizzo", "Lombardi", "Moretti",
    "Barbieri", "Fontana", "Santoro", "Mariani", "Rinaldi",
    "Caruso", "Ferrara", "Galli", "Martini", "Leone",
    "Longo", "Gentile", "Martinelli", "Vitale", "Lombardo",
    "Serra", "Coppola", "De Santis", "D'Angelo", "Marchetti",
};

const prefix = [_][]const u8{
    "Sig.", "Sig.ra", "Sig.na", "Dott.", "Dott.ssa",
    "Prof.", "Ing.", "Avv.",
};

const job_title = [_][]const u8{
    "Direttore", "Manager", "Coordinatore", "Responsabile", "Assistente",
    "Sviluppatore", "Ingegnere", "Architetto", "Designer", "Analista",
    "Contabile", "Avvocato", "Medico", "Professore", "Consulente",
};

const street_name = [_][]const u8{
    "Via Roma", "Corso Italia", "Piazza Garibaldi", "Via Nazionale",
    "Viale Europa", "Via Vittorio Emanuele", "Corso Vittorio Emanuele", "Via Cavour",
    "Piazza della Repubblica", "Via Mazzini", "Corso Umberto", "Via Dante",
};

const city = [_][]const u8{
    "Roma", "Milano", "Napoli", "Torino", "Palermo",
    "Genova", "Bologna", "Firenze", "Bari", "Catania",
    "Venezia", "Verona", "Messina", "Padova", "Trieste",
    "Brescia", "Taranto", "Prato", "Parma", "Modena",
};

const state = [_][]const u8{
    "Abruzzo", "Basilicata", "Calabria", "Campania", "Emilia-Romagna",
    "Friuli-Venezia Giulia", "Lazio", "Liguria", "Lombardia", "Marche",
    "Molise", "Piemonte", "Puglia", "Sardegna", "Sicilia",
    "Toscana", "Trentino-Alto Adige", "Umbria", "Valle d'Aosta", "Veneto",
};

const state_abbr = [_][]const u8{
    "AB", "BS", "CL", "CM", "ER", "FVG", "LZ", "LG", "LM", "MR",
    "ML", "PM", "PG", "SR", "SC", "TS", "TAA", "UM", "VA", "VN",
};

const country = [_][]const u8{
    "Italia", "Svizzera", "Francia", "Germania", "Spagna",
    "Austria", "Regno Unito", "Stati Uniti", "Canada", "Australia",
};

const postal_code_format = [_][]const u8{ "#####" };

const company_suffix = [_][]const u8{
    "S.p.A.", "S.r.l.", "S.n.c.", "S.a.s.", "Gruppo",
};

const domain_suffix = [_][]const u8{
    ".it", ".com", ".net", ".org", ".eu",
};

const phone_format = [_][]const u8{
    "+39 ### ### ####",
    "### ### ####",
};

pub const it: locale.LocaleDefinition = .{
    .title = "Italiano",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &[_][]const u8{},
        .job_title = &job_title,
        .gender = &[_][]const u8{ "Maschile", "Femminile", "Non-binario" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &street_name,
        .city = &city,
        .state = &state,
        .state_abbr = &state_abbr,
        .country = &country,
        .postal_code_format = &postal_code_format,
        .building_number = &[_][]const u8{ "#", "##", "###" },
        .direction = &[_][]const u8{ "Nord", "Sud", "Est", "Ovest" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = locale.CompanyLocale{
        .name = &[_][]const u8{ "Soluzioni", "Tecnologia", "Servizi", "Sistemi" },
        .suffix = &company_suffix,
        .industry = &[_][]const u8{ "Tecnologia", "Commercio", "Servizi", "Manifattura" },
        .buzzwords = &[_][]const u8{ "innovativo", "efficiente", "digitale", "intelligente" },
        .descriptor = &[_][]const u8{ "innovativo", "leader", "premium", "professionale" },
    },
    .internet = locale.InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "libero.it", "virgilio.it", "hotmail.it", "tim.it" },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format,
    },
    .food = en.food,
    .animal = en.animal,
};
