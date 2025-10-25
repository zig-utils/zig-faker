// French (Français) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

// French first names (male)
const first_name_male = [_][]const u8{
    "Alexandre", "Antoine", "Arthur", "Aurélien", "Baptiste",
    "Benjamin", "Charles", "Clément", "Damien", "David",
    "Dylan", "Enzo", "Étienne", "Fabien", "Florian",
    "François", "Gabriel", "Guillaume", "Hugo", "Jacques",
    "Jean", "Jérôme", "Julien", "Kevin", "Laurent",
    "Louis", "Lucas", "Marc", "Mathieu", "Maxime",
    "Nathan", "Nicolas", "Olivier", "Paul", "Philippe",
    "Pierre", "Quentin", "Raphaël", "Rémi", "Romain",
    "Samuel", "Sébastien", "Simon", "Thomas", "Tristan",
    "Victor", "Vincent", "Xavier", "Yann", "Yves",
};

// French first names (female)
const first_name_female = [_][]const u8{
    "Amélie", "Anaïs", "Anne", "Camille", "Caroline",
    "Catherine", "Céline", "Charlotte", "Chloé", "Claire",
    "Clémence", "Delphine", "Emma", "Émilie", "Eva",
    "Florence", "Françoise", "Hélène", "Inès", "Isabelle",
    "Jeanne", "Julie", "Laura", "Léa", "Léonie",
    "Louise", "Lucie", "Manon", "Margaux", "Marie",
    "Marine", "Martine", "Mathilde", "Nathalie", "Océane",
    "Pauline", "Sabrina", "Sandrine", "Sarah", "Sophie",
    "Stéphanie", "Suzanne", "Sylvie", "Valérie", "Victoria",
    "Virginie", "Yasmine", "Zoé", "Aurélie", "Laure",
};

// French last names
const last_name = [_][]const u8{
    "Martin", "Bernard", "Dubois", "Thomas", "Robert",
    "Richard", "Petit", "Durand", "Leroy", "Moreau",
    "Simon", "Laurent", "Lefebvre", "Michel", "Garcia",
    "David", "Bertrand", "Roux", "Vincent", "Fournier",
    "Morel", "Girard", "André", "Lefevre", "Mercier",
    "Dupont", "Lambert", "Bonnet", "François", "Martinez",
    "Legrand", "Garnier", "Faure", "Rousseau", "Blanc",
    "Guerin", "Muller", "Henry", "Roussel", "Nicolas",
    "Perrin", "Morin", "Mathieu", "Clément", "Gauthier",
    "Dumont", "Lopez", "Fontaine", "Chevalier", "Robin",
    "Masson", "Sanchez", "Gerard", "Nguyen", "Boyer",
    "Denis", "Lemaire", "Duval", "Joly", "Gautier",
    "Roger", "Roche", "Roy", "Noel", "Meyer",
    "Lucas", "Meunier", "Jean", "Perez", "Marchand",
    "Dufour", "Blanchard", "Marie", "Barbier", "Brun",
    "Dumas", "Brunet", "Schmitt", "Leroux", "Colin",
    "Fernandez", "Pierre", "Renard", "Arnaud", "Rolland",
    "Caron", "Giraud", "Leclerc", "Vidal", "Bourgeois",
    "Renaud", "Lemoine", "Picard", "Gaillard", "Philippe",
    "Leclercq", "Lacroix", "Fabre", "Dupuis", "Olivier",
};

// French name prefixes
const prefix = [_][]const u8{
    "M.", "Mme", "Mlle", "Dr", "Pr",
    "Me", "Mgr", "Ir", "Ing", "M. le",
};

// French name suffixes
const suffix = [_][]const u8{
    "Jr", "Sr", "II", "III", "fils",
};

// French job titles
const job_title = [_][]const u8{
    "Directeur", "Directrice", "Responsable", "Chef de projet", "Ingénieur",
    "Développeur", "Analyste", "Consultant", "Architecte", "Designer",
    "Comptable", "Avocat", "Médecin", "Professeur", "Infirmier",
    "Vendeur", "Administrateur", "Technicien", "Spécialiste", "Coordinateur",
    "Gestionnaire", "Assistant", "Secrétaire", "Commercial", "Formateur",
};

// French street names
const street_name = [_][]const u8{
    "Rue de la Paix", "Avenue des Champs-Élysées", "Boulevard Saint-Germain", "Rue de Rivoli",
    "Avenue Montaigne", "Rue du Faubourg Saint-Honoré", "Boulevard Haussmann", "Rue Lafayette",
    "Avenue Victor Hugo", "Rue de la République", "Place de la Concorde", "Quai Voltaire",
    "Rue Saint-Antoine", "Boulevard Voltaire", "Rue Montmartre", "Avenue Foch",
    "Rue du Commerce", "Boulevard Raspail", "Rue Saint-Denis", "Avenue Kléber",
};

// French cities
const city = [_][]const u8{
    "Paris", "Marseille", "Lyon", "Toulouse", "Nice",
    "Nantes", "Strasbourg", "Montpellier", "Bordeaux", "Lille",
    "Rennes", "Reims", "Le Havre", "Saint-Étienne", "Toulon",
    "Grenoble", "Dijon", "Angers", "Nîmes", "Villeurbanne",
    "Le Mans", "Aix-en-Provence", "Clermont-Ferrand", "Brest", "Tours",
    "Amiens", "Limoges", "Annecy", "Perpignan", "Boulogne-Billancourt",
    "Orléans", "Mulhouse", "Caen", "Nancy", "Argenteuil",
    "Montreuil", "Roubaix", "Tourcoing", "Avignon", "Dunkerque",
};

// French regions (post-2016 reform)
const state = [_][]const u8{
    "Auvergne-Rhône-Alpes", "Bourgogne-Franche-Comté", "Bretagne", "Centre-Val de Loire",
    "Corse", "Grand Est", "Hauts-de-France", "Île-de-France",
    "Normandie", "Nouvelle-Aquitaine", "Occitanie", "Pays de la Loire",
    "Provence-Alpes-Côte d'Azur", "Guadeloupe", "Martinique", "Guyane",
    "La Réunion", "Mayotte",
};

const state_abbr = [_][]const u8{
    "ARA", "BFC", "BRE", "CVL", "COR", "GES", "HDF", "IDF",
    "NOR", "NAQ", "OCC", "PDL", "PAC", "GUA", "MAR", "GUY",
    "REU", "MAY",
};

// French-speaking countries
const country = [_][]const u8{
    "France", "Belgique", "Suisse", "Canada", "Luxembourg",
    "Monaco", "Haïti", "Sénégal", "Côte d'Ivoire", "Madagascar",
    "Cameroun", "Burkina Faso", "Mali", "Niger", "Congo",
    "République démocratique du Congo", "Tchad", "Guinée", "Rwanda", "Burundi",
    "Bénin", "Togo", "République centrafricaine", "Gabon", "Comores",
    "Djibouti", "Seychelles", "Vanuatu", "Maroc", "Tunisie",
};

// French postal code formats
const postal_code_format = [_][]const u8{
    "#####",      // France standard
    "H#? #?#",    // Canada (Quebec)
    "####",       // Belgium
};

// French company names
const company_name = [_][]const u8{
    "Solutions", "Technologies", "Services", "Systèmes", "Innovation",
    "Développement", "Conseil", "Commerce", "Industrie", "Groupe",
    "Entreprise", "Corporation", "Associés", "Frères", "Produits",
};

const company_suffix = [_][]const u8{
    "SA", "SARL", "SAS", "SNC", "Groupe",
    "et Fils", "et Associés", "International", "France", "Europe",
};

// French industry types
const industry = [_][]const u8{
    "Technologie", "Commerce", "Services", "Fabrication", "Construction",
    "Alimentation", "Transport", "Éducation", "Santé", "Finance",
    "Tourisme", "Agriculture", "Énergie", "Télécommunications", "Automobile",
};

// French internet domains
const domain_suffix = [_][]const u8{
    ".fr", ".be", ".ch", ".ca", ".lu",
    ".com", ".net", ".org", ".info", ".eu",
};

// French phone formats
const phone_format = [_][]const u8{
    "+33 # ## ## ## ##",   // France
    "0# ## ## ## ##",      // France domestic
    "+32 ### ## ## ##",    // Belgium
    "+41 ## ### ## ##",    // Switzerland
    "+1 ### ###-####",     // Canada
    "## ## ## ## ##",
};

// Export French locale
pub const fr: locale.LocaleDefinition = .{
    .title = "Français",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &suffix,
        .job_title = &job_title,
        .gender = &[_][]const u8{ "Masculin", "Féminin", "Non-binaire" },
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
        .direction = &[_][]const u8{ "Nord", "Sud", "Est", "Ouest" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = locale.CompanyLocale{
        .name = &company_name,
        .suffix = &company_suffix,
        .industry = &industry,
        .buzzwords = &[_][]const u8{
            "innovant", "efficace", "durable", "numérique", "intelligent",
            "flexible", "évolutif", "robuste", "sécurisé", "rapide",
        },
        .descriptor = &[_][]const u8{
            "innovant", "leader", "premium", "professionnel", "fiable",
        },
    },
    .internet = locale.InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.fr", "yahoo.fr", "outlook.fr", "orange.fr",
            "free.fr", "laposte.net", "sfr.fr", "wanadoo.fr", "live.fr",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format,
    },
    .food = en.food,
    .animal = en.animal,
};
