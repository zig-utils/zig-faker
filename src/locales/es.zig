// Spanish (Español) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

// Spanish first names (male)
const first_name_male = [_][]const u8{
    "Alejandro", "Antonio", "Carlos", "Daniel", "David",
    "Diego", "Eduardo", "Fernando", "Francisco", "Gabriel",
    "Javier", "Jorge", "José", "Juan", "Luis",
    "Manuel", "Miguel", "Pablo", "Pedro", "Rafael",
    "Ramón", "Ricardo", "Roberto", "Santiago", "Sergio",
    "Adrián", "Alberto", "Álvaro", "Andrés", "Ángel",
    "Arturo", "Benjamín", "César", "Cristian", "Emilio",
    "Enrique", "Felipe", "Gonzalo", "Guillermo", "Gustavo",
    "Héctor", "Hugo", "Ignacio", "Iván", "Jaime",
    "Jesús", "Joaquín", "Leonardo", "Lorenzo", "Lucas",
    "Mario", "Martín", "Mateo", "Matías", "Nicolás",
    "Óscar", "Raúl", "Rodrigo", "Rubén", "Salvador",
    "Samuel", "Sebastián", "Tomás", "Vicente", "Víctor",
};

// Spanish first names (female)
const first_name_female = [_][]const u8{
    "Adriana", "Alejandra", "Ana", "Andrea", "Ángela",
    "Beatriz", "Camila", "Carmen", "Carolina", "Catalina",
    "Clara", "Claudia", "Cristina", "Diana", "Elena",
    "Gabriela", "Gloria", "Isabel", "Jimena", "Laura",
    "Lucía", "Margarita", "María", "Marta", "Natalia",
    "Patricia", "Paula", "Pilar", "Rosa", "Sofía",
    "Silvia", "Teresa", "Valentina", "Verónica", "Victoria",
    "Alicia", "Amparo", "Antonia", "Bárbara", "Blanca",
    "Carla", "Cecilia", "Dolores", "Emilia", "Esperanza",
    "Eva", "Fernanda", "Inés", "Irene", "Juana",
    "Julia", "Lorena", "Luisa", "Magdalena", "Manuela",
    "Marina", "Mercedes", "Mónica", "Nuria", "Olivia",
    "Raquel", "Rocío", "Sandra", "Sara", "Susana",
};

// Spanish last names
const last_name = [_][]const u8{
    "García", "Rodríguez", "Martínez", "López", "González",
    "Pérez", "Sánchez", "Ramírez", "Torres", "Flores",
    "Rivera", "Gómez", "Díaz", "Cruz", "Morales",
    "Reyes", "Gutiérrez", "Ortiz", "Chávez", "Ruiz",
    "Hernández", "Jiménez", "Álvarez", "Castillo", "Moreno",
    "Romero", "Herrera", "Medina", "Aguilar", "Vargas",
    "Castro", "Ramos", "Mendoza", "Vega", "Guerrero",
    "Navarro", "Núñez", "Silva", "Delgado", "Cortés",
    "Rojas", "Fernández", "Campos", "Santos", "Domínguez",
    "Vázquez", "Blanco", "León", "Ríos", "Fuentes",
    "Salazar", "Peña", "Benítez", "Acosta", "Sandoval",
    "Cabrera", "Carrillo", "Pacheco", "Miranda", "Estrada",
    "Molina", "Soto", "Contreras", "Guzmán", "Espinoza",
    "Gallardo", "Iglesias", "Suárez", "Mora", "Luna",
    "Cano", "Mendez", "Vera", "Lara", "Rubio",
    "Velázquez", "Parra", "Carmona", "Figueroa", "Arias",
    "Caballero", "Valencia", "Maldonado", "Campos", "Duran",
    "Serrano", "Marín", "Ponce", "Vidal", "Espino",
    "Gil", "Ávila", "Duarte", "Franco", "Córdoba",
    "Montes", "Montoya", "Zamora", "Cervantes", "Bustamante",
};

// Spanish name prefixes
const prefix = [_][]const u8{
    "Sr.", "Sra.", "Srta.", "Dr.", "Dra.",
    "Prof.", "Ing.", "Lic.", "Arq.", "Mtro.",
};

// Spanish name suffixes
const suffix = [_][]const u8{
    "Jr.", "Sr.", "II", "III", "IV",
};

// Spanish job titles
const job_title = [_][]const u8{
    "Gerente", "Director", "Coordinador", "Supervisor", "Asistente",
    "Desarrollador", "Ingeniero", "Arquitecto", "Diseñador", "Analista",
    "Contador", "Abogado", "Médico", "Profesor", "Consultor",
    "Vendedor", "Administrador", "Técnico", "Especialista", "Jefe",
    "Presidente", "Vicepresidente", "Secretario", "Tesorero", "Vocal",
};

// Spanish street names
const street_name = [_][]const u8{
    "Calle Principal", "Avenida Central", "Paseo de la Reforma", "Avenida Insurgentes",
    "Calle Juárez", "Avenida Hidalgo", "Calle Morelos", "Avenida Revolución",
    "Calle Independencia", "Paseo de Gracia", "Gran Vía", "Rambla",
    "Avenida Libertad", "Calle Mayor", "Plaza Mayor", "Calle Real",
    "Avenida del Sol", "Calle de la Luna", "Paseo Marítimo", "Malecón",
};

// Spanish cities
const city = [_][]const u8{
    "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza",
    "Málaga", "Murcia", "Palma", "Bilbao", "Alicante",
    "Córdoba", "Valladolid", "Vigo", "Gijón", "Granada",
    "México", "Guadalajara", "Monterrey", "Puebla", "Tijuana",
    "León", "Juárez", "Torreón", "Querétaro", "Mérida",
    "Buenos Aires", "Córdoba", "Rosario", "La Plata", "Mar del Plata",
    "Bogotá", "Medellín", "Cali", "Barranquilla", "Cartagena",
    "Lima", "Arequipa", "Trujillo", "Chiclayo", "Piura",
    "Santiago", "Valparaíso", "Concepción", "La Serena", "Antofagasta",
    "Quito", "Guayaquil", "Cuenca", "Santo Domingo", "Ambato",
};

// Spanish states/provinces
const state = [_][]const u8{
    "Andalucía", "Aragón", "Asturias", "Baleares", "Canarias",
    "Cantabria", "Castilla-La Mancha", "Castilla y León", "Cataluña", "Extremadura",
    "Galicia", "La Rioja", "Madrid", "Murcia", "Navarra",
    "País Vasco", "Valencia", "Aguascalientes", "Baja California", "Campeche",
    "Chiapas", "Chihuahua", "Coahuila", "Colima", "Durango",
    "Guanajuato", "Guerrero", "Hidalgo", "Jalisco", "México",
    "Michoacán", "Morelos", "Nayarit", "Nuevo León", "Oaxaca",
    "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí", "Sinaloa",
};

const state_abbr = [_][]const u8{
    "AN", "AR", "AS", "IB", "CN", "CB", "CM", "CL", "CT", "EX",
    "GA", "RI", "MD", "MU", "NC", "PV", "VC", "AG", "BC", "CM",
    "CS", "CH", "CO", "CL", "DG", "GT", "GR", "HG", "JA", "EM",
    "MI", "MO", "NA", "NL", "OA", "PU", "QT", "QR", "SL", "SI",
};

// Spanish countries (Spanish-speaking emphasis)
const country = [_][]const u8{
    "España", "México", "Argentina", "Colombia", "Perú",
    "Venezuela", "Chile", "Ecuador", "Guatemala", "Cuba",
    "Bolivia", "República Dominicana", "Honduras", "Paraguay", "El Salvador",
    "Nicaragua", "Costa Rica", "Panamá", "Uruguay", "Puerto Rico",
    "Guinea Ecuatorial", "Estados Unidos", "Francia", "Alemania", "Italia",
    "Brasil", "Portugal", "Reino Unido", "Canadá", "Japón",
};

// Spanish postal code formats
const postal_code_format = [_][]const u8{
    "#####",      // Spain, Mexico
    "C#### ???",  // Argentina
    "######",     // Colombia
};

// Spanish company names
const company_name = [_][]const u8{
    "Soluciones", "Tecnología", "Servicios", "Sistemas", "Innovación",
    "Desarrollo", "Consultoría", "Comercial", "Industrial", "Grupo",
    "Empresas", "Corporación", "Asociados", "Hermanos", "Productos",
};

const company_suffix = [_][]const u8{
    "S.A.", "S.L.", "S.C.", "Ltda.", "Cía.",
    "Grupo", "Hermanos", "e Hijos", "Asociados", "Internacional",
};

// Spanish industry types
const industry = [_][]const u8{
    "Tecnología", "Comercio", "Servicios", "Manufactura", "Construcción",
    "Alimentación", "Transporte", "Educación", "Salud", "Finanzas",
    "Turismo", "Agricultura", "Energía", "Telecomunicaciones", "Automotriz",
};

// Spanish internet domains
const domain_suffix = [_][]const u8{
    ".es", ".mx", ".ar", ".co", ".cl",
    ".pe", ".ve", ".ec", ".com", ".net",
    ".org", ".info", ".com.es", ".com.mx", ".gob.mx",
};

// Spanish phone formats
const phone_format = [_][]const u8{
    "+34 ### ### ###",     // Spain
    "+52 ## #### ####",    // Mexico
    "+54 9 11 ####-####",  // Argentina
    "+57 ### #######",     // Colombia
    "+56 9 #### ####",     // Chile
    "### ### ###",
    "(###) ###-####",
    "##-##-##-##-##",
};

// Export Spanish locale
pub const es: locale.LocaleDefinition = .{
    .title = "Español",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &suffix,
        .job_title = &job_title,
        .gender = &[_][]const u8{ "Masculino", "Femenino", "No binario" },
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
        .building_number = &[_][]const u8{ "#", "##", "###", "####" },
        .direction = &[_][]const u8{ "Norte", "Sur", "Este", "Oeste" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = locale.CompanyLocale{
        .name = &company_name,
        .suffix = &company_suffix,
        .industry = &industry,
        .buzzwords = &[_][]const u8{
            "innovador", "eficiente", "sostenible", "digital", "inteligente",
            "flexible", "escalable", "robusto", "seguro", "rápido",
        },
        .descriptor = &[_][]const u8{
            "innovador", "líder", "premium", "profesional", "confiable",
        },
    },
    .internet = locale.InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.com", "yahoo.es", "outlook.com", "hotmail.es",
            "correo.es", "latinmail.com", "prodigy.net.mx", "live.com.mx",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format,
    },
    .food = en.food,
    .animal = en.animal,
};
