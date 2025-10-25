// German (Deutsch) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

const first_name_male = [_][]const u8{
    "Alexander", "Andreas", "Anton", "Ben", "Benjamin",
    "Christian", "Daniel", "David", "Dennis", "Dominik",
    "Elias", "Emil", "Erik", "Fabian", "Felix",
    "Finn", "Florian", "Franz", "Friedrich", "Georg",
    "Hans", "Heinrich", "Henry", "Jakob", "Jan",
    "Jonas", "Jonathan", "Josef", "Julian", "Karl",
    "Klaus", "Leon", "Luca", "Lukas", "Malte",
    "Marcel", "Martin", "Marvin", "Matthias", "Max",
    "Maximilian", "Michael", "Moritz", "Niklas", "Noah",
    "Oliver", "Oscar", "Paul", "Peter", "Philipp",
    "Sebastian", "Simon", "Stefan", "Thomas", "Tim",
    "Tobias", "Tom", "Uwe", "Vincent", "Werner",
};

const first_name_female = [_][]const u8{
    "Alexandra", "Andrea", "Angela", "Angelika", "Anja",
    "Anna", "Annika", "Antonia", "Barbara", "Beate",
    "Birgit", "Brigitte", "Charlotte", "Christa", "Christina",
    "Christine", "Clara", "Claudia", "Dora", "Doris",
    "Elena", "Elisabeth", "Ella", "Emilia", "Emma",
    "Eva", "Franziska", "Frieda", "Gabriele", "Gisela",
    "Hannah", "Heike", "Helene", "Helga", "Ingrid",
    "Jana", "Johanna", "Julia", "Juliane", "Karin",
    "Katharina", "Klara", "Kristin", "Laura", "Lea",
    "Lena", "Leonie", "Luise", "Maria", "Marie",
    "Marina", "Martina", "Melanie", "Mia", "Monika",
    "Nadine", "Nicole", "Paula", "Petra", "Sabine",
    "Sandra", "Sara", "Silke", "Simone", "Sofia",
    "Sophia", "Sophie", "Stefanie", "Susanne", "Ursula",
};

const last_name = [_][]const u8{
    "Müller", "Schmidt", "Schneider", "Fischer", "Weber",
    "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann",
    "Schäfer", "Koch", "Bauer", "Richter", "Klein",
    "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann",
    "Braun", "Krüger", "Hofmann", "Hartmann", "Lange",
    "Schmitt", "Werner", "Schmitz", "Krause", "Meier",
    "Lehmann", "Schmid", "Schulze", "Maier", "Köhler",
    "Herrmann", "König", "Walter", "Mayer", "Huber",
    "Kaiser", "Fuchs", "Peters", "Lang", "Scholz",
    "Möller", "Weiß", "Jung", "Hahn", "Schubert",
    "Vogel", "Friedrich", "Keller", "Günther", "Frank",
    "Berger", "Winkler", "Roth", "Beck", "Baumann",
    "Kraus", "Schröder", "Vogt", "Sommer", "Kaufmann",
    "Ludwig", "Stein", "Franke", "Martin", "Krämer",
    "Böhm", "Schulte", "Hesse", "Beyer", "Seidel",
    "Arnold", "Brandt", "Winter", "Wolff", "Haas",
    "Schuster", "Lindner", "Kuhn", "Heinrich", "Engel",
    "Sauer", "Pohl", "Busch", "Horn", "Kunze",
    "Voigt", "Lemke", "Gross", "Riedel", "Kramer",
};

const prefix = [_][]const u8{
    "Herr", "Frau", "Dr.", "Prof.", "Prof. Dr.",
};

const suffix = [_][]const u8{
    "Jr.", "Sr.", "II", "III",
};

const job_title = [_][]const u8{
    "Geschäftsführer", "Direktor", "Manager", "Leiter", "Koordinator",
    "Entwickler", "Ingenieur", "Architekt", "Designer", "Analyst",
    "Buchhalter", "Rechtsanwalt", "Arzt", "Lehrer", "Berater",
    "Verkäufer", "Administrator", "Techniker", "Spezialist", "Assistent",
};

const street_name = [_][]const u8{
    "Hauptstraße", "Bahnhofstraße", "Schulstraße", "Kirchstraße", "Gartenstraße",
    "Bergstraße", "Waldstraße", "Ringstraße", "Lindenstraße", "Marktplatz",
    "Am Markt", "Dorfstraße", "Mühlenweg", "Kirchweg", "Poststraße",
    "Brunnenweg", "Fichtenweg", "Rosenweg", "Ahornweg", "Birkenweg",
};

const city = [_][]const u8{
    "Berlin", "Hamburg", "München", "Köln", "Frankfurt",
    "Stuttgart", "Düsseldorf", "Dortmund", "Essen", "Leipzig",
    "Bremen", "Dresden", "Hannover", "Nürnberg", "Duisburg",
    "Bochum", "Wuppertal", "Bielefeld", "Bonn", "Münster",
    "Karlsruhe", "Mannheim", "Augsburg", "Wiesbaden", "Gelsenkirchen",
    "Mönchengladbach", "Braunschweig", "Chemnitz", "Kiel", "Aachen",
    "Halle", "Magdeburg", "Freiburg", "Krefeld", "Lübeck",
    "Oberhausen", "Erfurt", "Mainz", "Rostock", "Kassel",
};

const state = [_][]const u8{
    "Baden-Württemberg", "Bayern", "Berlin", "Brandenburg", "Bremen",
    "Hamburg", "Hessen", "Mecklenburg-Vorpommern", "Niedersachsen", "Nordrhein-Westfalen",
    "Rheinland-Pfalz", "Saarland", "Sachsen", "Sachsen-Anhalt", "Schleswig-Holstein",
    "Thüringen",
};

const state_abbr = [_][]const u8{
    "BW", "BY", "BE", "BB", "HB", "HH", "HE", "MV",
    "NI", "NW", "RP", "SL", "SN", "ST", "SH", "TH",
};

const country = [_][]const u8{
    "Deutschland", "Österreich", "Schweiz", "Liechtenstein", "Luxemburg",
    "Belgien", "Frankreich", "Italien", "Niederlande", "Polen",
    "Tschechien", "Dänemark", "Schweden", "Norwegen", "Spanien",
};

const postal_code_format = [_][]const u8{
    "#####",  // German 5-digit postal code
};

const company_name = [_][]const u8{
    "Lösungen", "Technologie", "Dienste", "Systeme", "Innovation",
    "Entwicklung", "Beratung", "Handel", "Industrie", "Gruppe",
};

const company_suffix = [_][]const u8{
    "GmbH", "AG", "KG", "OHG", "GmbH & Co. KG",
    "e.K.", "Gruppe", "International", "Deutschland", "Europa",
};

const industry = [_][]const u8{
    "Technologie", "Handel", "Dienstleistungen", "Fertigung", "Bauwesen",
    "Ernährung", "Transport", "Bildung", "Gesundheit", "Finanzen",
    "Tourismus", "Landwirtschaft", "Energie", "Telekommunikation", "Automobil",
};

const domain_suffix = [_][]const u8{
    ".de", ".at", ".ch", ".com", ".net",
    ".org", ".info", ".eu", ".biz",
};

const phone_format = [_][]const u8{
    "+49 ### #######",     // Germany
    "+43 ### ######",      // Austria
    "+41 ## ### ## ##",    // Switzerland
    "0### #######",
    "(0###) #######",
};

pub const de: locale.LocaleDefinition = .{
    .title = "Deutsch",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &suffix,
        .job_title = &job_title,
        .gender = &[_][]const u8{ "Männlich", "Weiblich", "Nicht-binär" },
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
        .direction = &[_][]const u8{ "Nord", "Süd", "Ost", "West" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = locale.CompanyLocale{
        .name = &company_name,
        .suffix = &company_suffix,
        .industry = &industry,
        .buzzwords = &[_][]const u8{
            "innovativ", "effizient", "nachhaltig", "digital", "intelligent",
            "flexibel", "skalierbar", "robust", "sicher", "schnell",
        },
        .descriptor = &[_][]const u8{
            "innovativ", "führend", "premium", "professionell", "zuverlässig",
        },
    },
    .internet = locale.InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "gmx.de", "web.de", "t-online.de", "hotmail.de",
            "outlook.de", "yahoo.de", "freenet.de", "mail.de",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format,
    },
    .food = en.food,
    .animal = en.animal,
};
